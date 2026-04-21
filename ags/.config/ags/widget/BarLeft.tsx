import app from "ags/gtk4/app"
import { Astal } from "ags/gtk4"
import { Time } from "./Time"

export default function BarLeft(monitor = 1) {
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
                <box $type="center">
                    <Time format="%d.%m.%Y %H:%M" />
                </box>
            </centerbox>
        </window>
    )
}
