import { Gtk } from "ags/gtk4";
import Gio from "gi://Gio?version=2.0";
import { createBinding } from "gnim";
import BrightnessService from "../helpers/brightness";

export function Brightness() {
    // 1. Логика выбора иконки в зависимости от яркости
    const getBrightnessIcon = () => {
        const val = BrightnessService.screen_value * 100;

        if (val === 0) return "display-brightness-0-symbolic";
        if (val <= 14) return "display-brightness-1-symbolic";
        if (val <= 28) return "display-brightness-2-symbolic";
        if (val <= 42) return "display-brightness-3-symbolic";
        if (val <= 56) return "display-brightness-4-symbolic";
        if (val <= 70) return "display-brightness-5-symbolic";
        if (val <= 84) return "display-brightness-6-symbolic";

        return "display-brightness-7-symbolic";
    };

    return (
        <Gtk.Box>
            <box
                class="brightness-control"
                spacing={4}
                $={(self) => {
                    const scroll = new Gtk.EventControllerScroll({
                        flags: Gtk.EventControllerScrollFlags.VERTICAL,
                    });

                    scroll.connect("scroll", (_, __, dy) => {
                        const step = 0.03; // Шаг изменения 5%
                        const current = BrightnessService.screen_value;

                        // dy > 0 — прокрутка вниз, dy < 0 — вверх
                        if (dy > 0) {
                            BrightnessService.set_screen_value(current - step);
                        } else {
                            BrightnessService.set_screen_value(current + step);
                        }
                        return true;
                    });

                    self.add_controller(scroll);
                }}
            >
                <Gtk.Image
                    gicon={createBinding(BrightnessService, "screen_value")(() =>
                        Gio.ThemedIcon.new(getBrightnessIcon())
                    )}
                />
                <label
                    label={createBinding(BrightnessService, "screen_value")((v) =>
                        `${Math.round(v * 100)}%`
                    )}
                />
            </box>


            {/* Внешний монитор (ASUS VE278) */}
            {/* <Gtk.Box */}
            {/*     class="brightness-item external" */}
            {/*     // Проверяем наличие внешнего монитора через привязку к свойству сервиса */}
            {/*     // visible={createBinding(BrightnessService, "external_value")(v => v > 0)} */}
            {/*     $={(self) => { */}
            {/*         const scroll = new Gtk.EventControllerScroll({ */}
            {/*             flags: Gtk.EventControllerScrollFlags.VERTICAL, */}
            {/*         }); */}
            {/**/}
            {/**/}
            {/*         scroll.connect("scroll", (_, __, dy) => { */}
            {/*             const step = 0.05; */}
            {/*             const current = BrightnessService.external_value; */}
            {/*             // Вызываем метод именно у СЕРВИСА */}
            {/*             BrightnessService.set_external_value(dy > 0 ? current - step : current + step); */}
            {/*             return true; */}
            {/*         }); */}
            {/**/}
            {/*         self.add_controller(scroll); */}
            {/*     }} */}
            {/* > */}
            {/*     <Gtk.Image iconName="video-display-symbolic" /> */}
            {/*     <label */}
            {/*         label={createBinding(BrightnessService, "external_value")(v => */}
            {/*             `${Math.round(v * 100)}%` */}
            {/*         )} */}
            {/*     /> */}
            {/* </Gtk.Box> */}



        </Gtk.Box >
    );
}
