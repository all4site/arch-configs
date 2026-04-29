import GObject, { register, property, signal } from "ags/gobject";
import { exec, execAsync } from "ags/process";
import { monitorFile } from "ags/file";
// Используем импорт строго по твоему указанию
import { timeout } from "ags/time";

@register({ GTypeName: "BrightnessService" })
export class BrightnessService extends GObject.Object {
    @property(Number) screen_value = 0;
    @property(Number) external_value = 0;

    @signal(Number)
    changed(value: number) { }

    private _interface: string;
    // Храним ссылку на объект Timer, чтобы иметь доступ к .cancel()
    private _ddcTimer: any = null;

    constructor() {
        super();

        // 1. Внутренний дисплей (backlight)
        this._interface = exec("sh -c 'ls /sys/class/backlight | head -n 1'");
        const path = `/sys/class/backlight/${this._interface}/brightness`;

        monitorFile(path, () => this.#onInternalChange());
        this.#onInternalChange();

        // 2. Внешний монитор (DDC/CI)
        this.#updateExternalInitial();
    }

    /**
     * Установка яркости внешнего монитора.
     * Использует объектный метод .cancel() для предотвращения коллизий на шине I2C.
     */
    set_external_value(percent: number) {
        percent = Math.max(0, Math.min(1, percent));
        this.external_value = percent;

        // В твоем классе Timer отмена производится методом .cancel()
        if (this._ddcTimer) {
            this._ddcTimer.cancel();
        }

        // Вызов возвращает объект Timer (согласно твоему коду)
        this._ddcTimer = timeout(300, () => {
            const val = Math.floor(this.external_value * 100);
            execAsync(`ddcutil setvcp 10 ${val}`)
                .catch((err) => console.error(`DDCutil Error: ${err}`));

            this._ddcTimer = null;
        });
    }

    set_screen_value(percent: number) {
        percent = Math.max(0, Math.min(1, percent));
        execAsync(`brightnessctl set ${Math.floor(percent * 100)}% -q`)
            .then(() => {
                this.screen_value = percent;
                this.emit("changed", percent);
            });
    }

    async #updateExternalInitial() {
        try {
            const out = await execAsync("ddcutil getvcp 10 -t");
            const parts = out.split(" ");
            // CNC (Current Value) — 4-й элемент в terse выводе
            this.external_value = parseInt(parts[3]) / parseInt(parts[4]);
        } catch {
            this.external_value = 0;
        }
    }

    #onInternalChange() {
        const max = Number(exec('brightnessctl max'));
        const curr = Number(exec('brightnessctl get'));
        const percent = curr / max;

        if (percent !== this.screen_value) {
            this.screen_value = percent;
            this.emit("changed", percent);
        }
    }
}

export default new BrightnessService();
