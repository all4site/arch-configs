import { createPoll } from "ags/time"
import { Gtk } from "ags/gtk4"
import { Accessor } from "gnim"
import { exec } from "ags/process"
import Gio from "gi://Gio?version=2.0"

export function Cpu() {
    const temp = createPoll("0°C", 5000, () => {
        try {
            // Ищем строку Package id 0 в coretemp-isa-0000
            const out = exec("sensors")
            const match = out.match(/Package id 0:\s+\+([\d\.]+)/)
            return match ? `${Math.floor(parseFloat(match[1]))}°C` : "N/A"
        } catch (e) {
            console.error("CPU Widget Error:", e)
            return "0°C"
        }
    }) as Accessor<string>

    return (
        <box class="cpu-widget" spacing={4}>
            <Gtk.Image gicon={Gio.ThemedIcon.new("cpu-symbolic")} />
            <label label={temp} />
        </box>
    )
}
