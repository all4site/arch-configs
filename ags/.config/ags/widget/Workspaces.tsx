import Hyprland from "gi://AstalHyprland"
import { createState, For } from "gnim"

export function Workspaces() {
    const hypr = Hyprland.get_default()

    // Функция для формирования строки из текущих окон
    // const getClientsStringOne = () => hypr.get_clients()
    //     .filter(e => e.workspace.id >= 0)
    //     .sort((a, b) => a.workspace.id - b.workspace.id)
    //     .map(c => c)

    const getClientsString = () => {
        const clients = hypr.get_clients()
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

    hypr.connect("notify::clients", () => {
        const newData = getClientsString()
        setClientsData([...newData])
    })

    hypr.connect("client-moved", () => {
        setClientsData(getClientsString())
    })


    return (
        <box class="Workspaces">
            {/* {JSON.stringify(clientsData())} */}
            <For each={clientsData} >
                {(ws: any) => (
                    <button class="client-button"
                        onClicked={() => hypr.dispatch('workspace', String(ws.id))}
                    >
                        <label label={`${ws.id}:${ws.classes.join(" ")} `} />
                    </button>
                )}
            </For>
        </box>
    )
}
