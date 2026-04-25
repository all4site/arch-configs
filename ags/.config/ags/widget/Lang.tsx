import Hyprland from "gi://AstalHyprland";
import { createState } from "gnim";
import { getMainLayout } from "../helpers/getMainLayout";


export function Keyboard() {
    const hypr = Hyprland.get_default()!;

    const [layout, setLayout] = createState(getMainLayout());

    hypr.connect("keyboard-layout", (_, __, layoutName) => {
        setLayout(layoutName.slice(0, 2).toUpperCase());
    });

    return (
        <button
            class="lang-switcher"
            onClicked={() => hypr.message("switchxkblayout current next")}
        >
            <label
                class={"lang-text"}
                label={layout}
            />
        </button>
    );
}
