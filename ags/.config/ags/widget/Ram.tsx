import { createPoll } from "ags/time"
import { Gtk } from "ags/gtk4"
import { Accessor } from "gnim"
import { exec } from "ags/process"
import Gio from "gi://Gio?version=2.0"

export function Ram() {
    const ram = createPoll("0 GB", 5000, () => {
        try {
            const out = exec("free -m")
            const lines = out.split("\n")
            const memLine = lines[1].split(/\s+/)
            const usedMB = parseInt(memLine[2])
            return `${(usedMB / 1024).toFixed(1)} GB`
        } catch (e) {
            console.error("RAM Widget Error:", e)
            return "0 GB"
        }
    }) as Accessor<string>

    return (
        <box class="ram-widget" spacing={4}>
            <Gtk.Image gicon={Gio.ThemedIcon.new("memory-symbolic")} />
            <label label={ram} />
        </box>
    )
}
