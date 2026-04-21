import { createPoll } from "ags/time"
import GLib from "gi://GLib?version=2.0"

export function Time({ format = "%H:%M" }) {
    const time = createPoll("", 1000, () => {
        return GLib.DateTime.new_now_local().format(format)!
    })

    return (
        <menubutton>
            <label label={time} />
        </menubutton>
    )
}
