import Hyprland from "gi://AstalHyprland";
import { createState, onCleanup } from "gnim";

function getMainLayout() {
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

export function Keyboard() {
    const hypr = Hyprland.get_default()!;

    // 1. Инициализируем состояние коротким именем сразу при загрузке
    const [layout, setLayout] = createState({
        short: getMainLayout()
    });

    // 2. Слушаем изменения раскладки в реальном времени
    const id = hypr.connect("keyboard-layout", (_, __, layoutName) => {
        if (layoutName) {
            setLayout({
                short: layoutName.slice(0, 2).toUpperCase()
            });
        }
    });

    // 3. Очистка ресурсов
    onCleanup(() => hypr.disconnect(id)); return (
        <button
            class="lang-switcher"
            onClicked={() => hypr.message("switchxkblayout current next")}
        >
            {/* Используем Accessor как функцию: l => l.short */}
            <label
                label={layout(l => l.short)}
            />
        </button>
    );
}
