import { Gtk } from "ags/gtk4";
import Hyprland from "gi://AstalHyprland"
import { createState, For } from "gnim"

export function Workspaces() {
    const hypr = Hyprland.get_default()


    const getClientsString = () => {
        const clients = hypr.clients
            .filter(c => c.workspace.id >= 0)
            .sort((a, b) => a.workspace.id - b.workspace.id);

        // Группируем по workspace.id
        const grouped = clients.reduce((acc: any, c) => {
            const wsId = c.workspace.id;
            if (!acc[wsId]) {
                acc[wsId] = { id: wsId, classes: [] };
            }
            acc[wsId].classes.push(c.class);
            return acc;
        }, {});

        // Возвращаем массив для итерации в <For>
        return Object.values(grouped);
    }

    const [clientsData, setClientsData] = createState<any>(getClientsString())

    const [activeWs, setActiveWs] = createState<number>(hypr.focused_workspace.id)

    hypr.connect("notify::clients", () => {
        const newData = getClientsString()
        setClientsData([...newData])
    })

    hypr.connect("client-moved", () => {
        setClientsData(getClientsString())
    })

    // Обновляем активный воркспейс при смене фокуса
    hypr.connect("notify::focused-workspace", () => {
        const newId = hypr.focused_workspace.id;
        setActiveWs(newId);
        setClientsData([...getClientsString()]);
    })

    return (
        <box class="Workspaces">
            {/* {JSON.stringify(activeWs())} */}
            <For each={clientsData}>
                {(ws: any) => (
                    <button
                        class={`client-button ${activeWs() === ws.id ? "active" : ""}`}
                        onClicked={() => hypr.dispatch('workspace', String(ws.id))}
                    >
                        <box spacing={4} class={'ws-icons'}>
                            <label label={`${ws.id}:`} class="ws-id" />
                            <box spacing={2}>
                                {ws.classes.map((className: string) => (
                                    <Gtk.Image
                                        iconName={className}
                                        class="app-icon"
                                        pixelSize={18}
                                    />
                                ))}
                            </box>
                        </box>
                    </button>
                )}
            </For>
        </box>
    )
}
