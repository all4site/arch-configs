import { Gtk } from "ags/gtk4";
import { createState, For } from "gnim";
import Hyprland from "gi://AstalHyprland"

export function Ws({ monitor }: { monitor: any }) {
    const hypr = Hyprland.get_default()

    const getWorkspacesData = () => {
        const allWorkspaces = hypr.workspaces;
        const allClients = hypr.clients;

        // Берем список всех существующих воркспейсов (включая пустые persistent)
        return allWorkspaces
            .filter(ws => ws.id >= 0 && ws.monitor.id === monitor) // Игнорируем специальные (scratchpads)
            .sort((a, b) => a.id - b.id)
            .map(ws => {
                // Для каждого воркспейса ищем все окна, которые на нем находятся
                const icons = allClients
                    .filter(client => client.workspace.id === ws.id)
                    .map(client => client.class);

                return {
                    id: ws.id,
                    classes: icons,
                    isEmpty: icons.length === 0
                };
            });
    }

    const [clientsData, setClientsData] = createState<any>(getWorkspacesData())
    const [activeWs, setActiveWs] = createState<number>(hypr.focused_workspace.id)

    // Обновление при любых изменениях клиентов (открытие, закрытие, перемещение)
    const update = () => setClientsData(getWorkspacesData());

    hypr.connect("notify::clients", update)
    hypr.connect("client-moved", update)

    // Обновляем активный воркспейс и данные
    hypr.connect("notify::focused-workspace", () => {
        setActiveWs(hypr.focused_workspace.id);
        update();
    })

    return (
        <box class="Workspaces">
            <For each={clientsData}>
                {(ws: any) => (
                    <button
                        class={`client-button ${activeWs() === ws.id ? "active" : ""}`}
                        onClicked={() => hypr.dispatch('workspace', String(ws.id))}
                    >
                        <box spacing={4} class={'ws-icons'}>
                            <label
                                label={ws.isEmpty ? `${ws.id}` : `${ws.id}`} class={'ws-id'} />

                            <box spacing={4}>
                                {ws.classes.map((className: string) => (
                                    <Gtk.Image
                                        iconName={`${className}-symbolic`}
                                        class="app-icon"
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
