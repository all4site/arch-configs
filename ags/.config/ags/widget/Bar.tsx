import app from "ags/gtk4/app"
import { Astal } from "ags/gtk4"
import { Time } from "./Time"
import { Ws } from "./Ws"
import { SystemTray } from "./tray"
import { Keyboard } from "./Lang"

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
                    <Ws monitor={monitor} />
                </box>
                <box $type="center">
                    <Time format="%a %d.%m.%Y %H:%M" />
                </box>
                <box $type="end">
                    <Keyboard />
                    <SystemTray />
                </box>
            </centerbox>
        </window>
    )
}
