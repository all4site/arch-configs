import { Gdk, Gtk } from "ags/gtk4";
import Gio from "gi://Gio?version=2.0";

export function getTrayIcon(item: any) {
    const display = Gdk.Display.get_default();
    const theme = Gtk.IconTheme.get_for_display(display || Gdk.Display.open(null)!);
    const fromTheme = (name: string) => Gio.ThemedIcon.new(name);

    // Берем все возможные ID для проверки
    const busId = (item.id || "").toLowerCase();
    const appId = (item.item_id || "").toLowerCase();
    const iconName = (item.icon_name || "").toLowerCase();
    // console.log(iconName)

    // 1. Проверка на Chrome/Chromium (по твоему новому логу 'chrome_status_icon_1')
    if (busId.includes("chrome") || appId.includes("chrome")) {
        return fromTheme("google-chrome");
    }

    // 2. Проверка на Telegram
    if (appId.includes("telegram") || iconName.includes("telegram") || busId.includes("telegram")) {
        if (iconName.includes("attention")) return fromTheme("telegram-attention-panel")

        return fromTheme("telegram-desktop");
    }

    // 3. Проверка на Steam
    if (appId.includes("steam") || iconName.includes("steam") || busId.includes("steam")) {
        return fromTheme("steam");
    }

    // 4. Если имя иконки есть в системе и оно подходит под тему
    if (item.icon_name && theme.has_icon(item.icon_name)) {
        return fromTheme(item.icon_name);
    }

    // 5. Жесткий фолбек: возвращаем оригинальный объект gicon,
    // чтобы иконка не пропала, если мы ее не узнали.
    return item.gicon;
}


