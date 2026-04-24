import app from "ags/gtk4/app"
import { Astal } from "ags/gtk4"
import { Time } from "./Time"
import { Workspaces } from "./Workspaces"

export default function Bar(monitor = 1) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return (
        <window
            visible
            name="bar"
            class="bar"
            monitor={monitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={TOP | LEFT | RIGHT}
            application={app}
        >
            <centerbox cssName="centerbox">
                <box $type="start" >
                    <Workspaces />
                </box>
                <box $type="center">
                    <Time format="%a %d.%m.%Y %H:%M" />
                </box>
                <box $type="end">
                    end
                </box>
            </centerbox>
        </window>
    )
}
