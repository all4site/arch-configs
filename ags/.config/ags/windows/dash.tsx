import { Astal, Gtk, Gdk } from "ags/gtk4"
import app from "ags/gtk4/app"
import { CpuProgress } from "../widget/CpuProgress"
import { RamProgress } from "../widget/RamProgress"
import { GpuProgress } from "../widget/GpuProgress"
import { IgpuProgress } from "../widget/IgpuProgress"

export default function Dash(monitor = 1) {
    return (
        <window
            visible={true}
            name="dash"
            application={app}
            layer={Astal.Layer.TOP}
            anchor={Astal.WindowAnchor.TOP}
            exclusivity={Astal.Exclusivity.IGNORE}
            class={'dash'}
            // keymode={Astal.Keymode.ON_DEMAND}
            keymode={Astal.Keymode.NONE}
            monitor={monitor}
            focusable={false}

        >
            <Gtk.EventControllerKey
                onKeyPressed={(_, keyval) => {
                    if (keyval === Gdk.KEY_Escape) {
                        const win = app.get_window("dash")
                        if (win) win.visible = false
                    }
                }}
            />
            <box valign={Gtk.Align.START} class={'progress'}>
                <RamProgress />
                <CpuProgress />
                <GpuProgress />
                <IgpuProgress />
            </box>
        </window>
    )
}

