import { Gtk } from "ags/gtk4";
import AstalTray from "gi://AstalTray?version=0.1";

export function setupTrayItemEvents(self: Gtk.Widget, item: AstalTray.TrayItem) {
    // 1. Создаем и настраиваем меню, если оно есть
    if (item.menu_model) {
        const popover = Gtk.PopoverMenu.new_from_model(item.menu_model);
        popover.insert_action_group("dbusmenu", item.action_group);
        popover.set_parent(self);
        popover.has_arrow = false;

        // Жест для правой кнопки (вызов меню)
        const secondaryGesture = Gtk.GestureClick.new();
        secondaryGesture.set_button(3);
        secondaryGesture.connect("released", () => {
            item.about_to_show();
            popover.popup();
        });
        self.add_controller(secondaryGesture);
    }

    // 2. Жест для левой кнопки (активация)
    const primaryGesture = Gtk.GestureClick.new();
    primaryGesture.set_button(1);
    primaryGesture.connect("released", (_, __, x, y) => {
        item.activate(Math.round(x), Math.round(y));
    });
    self.add_controller(primaryGesture);
}
