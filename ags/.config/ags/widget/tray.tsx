import { Gtk } from "ags/gtk4";
import { createState, For } from "gnim";
import Tray from "gi://AstalTray"
import { getTrayIcon } from "../helpers/getTrayIcon";
import AstalTray from "gi://AstalTray";
import { setupTrayItemEvents } from "../helpers/traypopup";
import { watchItemChanges } from "../helpers/watchItemChanges";


export function SystemTray() {
    const tray = Tray.get_default();

    // Функция для получения честного JS-массива из GList
    const getItems = () => Array.from(tray.get_items());

    const [items, setItems] = createState(getItems());

    const update = () => setItems(getItems());

    tray.connect("item-added", update);
    tray.connect("item-removed", update);
    tray.connect("notify::items", update);

    return (
        <Gtk.Box class="tray" spacing={8}>
            <For each={items}>
                {(item: AstalTray.TrayItem) => (
                    <button
                        class="item"
                        tooltipText="" // Убираем подсказки
                        $={(self) => {
                            setupTrayItemEvents(self, item);
                            watchItemChanges(self, item)
                        }}
                    >
                        <Gtk.Image
                            gicon={getTrayIcon(item)}
                            pixelSize={16}
                        />
                    </button>
                )}
            </For>
        </Gtk.Box >
    );
}
