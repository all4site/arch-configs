import { createPoll } from "ags/time"
import GLib from "gi://GLib?version=2.0"
import { Accessor } from "gnim"

export function Time({ format = "%H:%M" }) {

    const time = createPoll("", 1000, () => {
        return GLib.DateTime.new_now_local().format(format)?.toUpperCase()
    }) as Accessor<string>

    return (
        <menubutton>
            <label label={time} />
        </menubutton>
    )
}
