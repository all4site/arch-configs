import Battery from "gi://AstalBattery"
import { createBinding, createComputed } from "ags"
import { Gtk } from "ags/gtk4"
import Gio from "gi://Gio?version=2.0"


export function BatteryWidget() {
    // Получаем доступ к системному сервису батареи
    const battery = Battery.get_default()

    // 1. Создаем реактивное вычисляемое свойство (Accessor)
    // Оно автоматически подпишется на оба биндинга
    const iconName = createComputed([
        createBinding(battery, "percentage"),
        createBinding(battery, "charging")
    ], (p, charging) => {
        const percent = p * 100;

        // Если кабель подключен, показываем молнию
        if (charging) return "battery-charging-symbolic";

        // Твои 8 состояний яркости/лун
        if (percent === 0) return "display-brightness-0-symbolic";
        if (percent <= 14) return "display-brightness-1-symbolic";
        if (percent <= 28) return "display-brightness-2-symbolic";
        if (percent <= 42) return "display-brightness-3-symbolic";
        if (percent <= 56) return "display-brightness-4-symbolic";
        if (percent <= 70) return "display-brightness-5-symbolic";
        if (percent <= 84) return "display-brightness-6-symbolic";

        return "display-brightness-7-symbolic";
    });


    return (
        <box class="battery-widget">
            <Gtk.Image
                gicon={iconName.as(name => Gio.ThemedIcon.new(name))}
            />
            <label
                label={createBinding(battery, "percentage").as(p =>
                    `${Math.floor(p * 100)}%`
                )}
            />
        </box>
    )
}
