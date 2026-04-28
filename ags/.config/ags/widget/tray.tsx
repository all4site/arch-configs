import { Gtk } from "ags/gtk4";
import { createBinding, createState, For } from "gnim";
import Tray from "gi://AstalTray"
import AstalTray from "gi://AstalTray";
import { setupTrayItemEvents } from "../helpers/traypopup";
import Gio from "gi://Gio?version=2.0";


export function SystemTray() {
    const tray = Tray.get_default();

    // Функция для получения честного JS-массива из GList
    const getItems = () => Array.from(tray.get_items());

    const [items, setItems] = createState(getItems());

    const update = () => setItems(getItems());

    tray.connect("item-added", update);
    tray.connect("item-removed", update);
    tray.connect("notify::items", update);

    const getSymbolicIcon = (item: AstalTray.TrayItem) => {
        // console.log(`Tray ID: ${item.id} | Name: ${item.iconName}`)

        const finalName = item.icon_name || item.id;

        const baseName = finalName.endsWith("-symbolic")
            ? finalName
            : `${finalName}-symbolic`;


        // console.log("Base name", baseName)
        return Gio.ThemedIcon.new(baseName);
    };

    tray.connect('notify::icon-name', getSymbolicIcon)

    return (
        <Gtk.Box class="tray" spacing={8}>
            <For each={items}>
                {(item: AstalTray.TrayItem) => (
                    < button
                        class="tray-item"
                        tooltipText=""
                        $={(self) => {
                            setupTrayItemEvents(self, item);
                        }}
                    >
                        <Gtk.Image
                            gicon={createBinding(item, "iconName")(() =>
                                getSymbolicIcon(item)
                            )}
                        />



                    </button>
                )}
            </For>
        </Gtk.Box >
    );
}
