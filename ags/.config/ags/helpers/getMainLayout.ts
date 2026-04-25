import Hyprland from "gi://AstalHyprland";

export function getMainLayout() {
    const hypr = Hyprland.get_default()!;
    try {
        const response = hypr.message("j/devices");
        const { keyboards } = JSON.parse(response);

        // Ищем активную клавиатуру
        const main = keyboards.find((k: any) => k.main) || keyboards[0];
        const layoutName = main?.active_keymap || "Unknown";

        // Превращаем "English (US)" или "Russian" в "EN" или "RU"
        return layoutName.slice(0, 2).toUpperCase();
    } catch (e) {
        console.error("Ошибка при получении раскладки:", e);
        return "--";
    }
}

