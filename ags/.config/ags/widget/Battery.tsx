import Battery from "gi://AstalBattery"
import { createBinding, createState } from "ags"
import { Gtk } from "ags/gtk4"
import Gio from "gi://Gio?version=2.0"


export function BatteryWidget() {
    const battery = Battery.get_default()

    const getBatteryIconName = () => {
        const percent = battery.percentage * 100
        const level = percent === 0 ? 0 : Math.ceil(percent / 10) * 10
        const chargingSuffix = (battery.state === 5) ? "-charging" : ""

        return `battery-level-${Math.min(level, 100)}${chargingSuffix}-symbolic`
    }

    const [iconName, setIconName] = createState(getBatteryIconName())

    battery.connect("notify::percentage", () => setIconName(getBatteryIconName()))
    battery.connect("notify::state", () => setIconName(getBatteryIconName()))

    return (
        <box class="battery-widget">
            <Gtk.Image
                gicon={iconName.as(name => Gio.ThemedIcon.new(name))}
            />
            <label
                label={createBinding(battery, "percentage").as(p =>
                    `${Math.floor(p * 100)} % `
                )}
            />
        </box>
    )
}
