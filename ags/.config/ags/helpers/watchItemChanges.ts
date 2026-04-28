import { Gtk } from "ags/gtk4";
import AstalTray from "gi://AstalTray";
import { getTrayIcon } from "../helpers/getTrayIcon";

export function watchItemChanges(self: Gtk.Button, item: AstalTray.TrayItem) {
    const update = () => {
        const img = self.get_child();
        if (img instanceof Gtk.Image) {
            // console.log(`Update icon for: ${item.id}`);
            img.gicon = getTrayIcon(item);
        }
    };


    // Подключаем сигнал
    const id = item.connect("changed", update);

    // Важно: отключаем сигнал, когда кнопка удаляется из памяти 
    self.connect("destroy", () => item.disconnect(id));
}
