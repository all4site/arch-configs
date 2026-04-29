import { Gtk } from "ags/gtk4";
import { createBinding } from "ags";
import Wp from "gi://AstalWp";
import Gio from "gi://Gio?version=2.0";


export function Volume() {
    const speaker = Wp.get_default()?.audio.default_speaker;

    if (!speaker) return <label label="No Audio" />;

    // 1. Логика выбора иконки в зависимости от громкости
    const getVolumeIcon = () => {
        if (speaker.mute) return "audio-volume-muted-symbolic";

        const vol = speaker.volume * 100;
        if (vol === 0) return "audio-volume-muted-symbolic";
        if (vol < 33) return "audio-volume-low-symbolic";
        if (vol < 67) return "audio-volume-medium-symbolic";
        return "audio-volume-high-symbolic";
    };

    return (
        <Gtk.Box
            class="volume-control"
            $={(self) => {
                const scroll = new Gtk.EventControllerScroll({
                    flags: Gtk.EventControllerScrollFlags.VERTICAL,
                });

                scroll.connect("scroll", (_, __, dy) => {
                    const step = 0.03;
                    // dy > 0 — прокрутка вниз, dy < 0 — вверх
                    if (dy > 0) {
                        speaker.volume = Math.max(0, speaker.volume - step);
                    } else {
                        speaker.volume = Math.min(1, speaker.volume + step);
                    }
                    return true; // Останавливаем всплытие события
                });

                self.add_controller(scroll);
            }}
        >


            <Gtk.Image
                gicon={createBinding(speaker, "volume")(() =>
                    Gio.ThemedIcon.new(getVolumeIcon())
                )}
            />
            <label
                label={createBinding(speaker, "volume")((v) =>
                    `${Math.round(v * 100)}%`
                )}
            />
        </Gtk.Box>
    );
}
