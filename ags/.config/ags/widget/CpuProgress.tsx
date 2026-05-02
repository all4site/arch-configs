import { Gtk } from "ags/gtk4"
import { createPoll } from "ags/time"
import { Accessor } from "gnim"
import { PROGRESS_LINE_WIDTH, PROGRESS_SIZE } from "../helpers/constants"

export function CpuProgress() {
    const cpu = createPoll(0, 2000,
        "bash -c \"top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}'\"",
        (out) => Math.round(parseFloat(out))
    ) as Accessor<number>

    return (
        <overlay class="cpu-progress-container" >
            <drawingarea
                class="cpu-progress-draw"
                $={(self) => {
                    self.set_size_request(PROGRESS_SIZE, PROGRESS_SIZE)
                    self.set_draw_func((area, cr, width, height) => {
                        const val = cpu() / 100
                        const radius = Math.min(width, height) / 2 - 5
                        const center = { x: width / 2, y: height / 2 }



                        // Фон
                        cr.setSourceRGB(0.2, 0.2, 0.2)
                        cr.arc(center.x, center.y, radius, 0, 2 * Math.PI)
                        cr.setLineWidth(PROGRESS_LINE_WIDTH)
                        cr.stroke()

                        // Прогресс
                        cr.setSourceRGB(235 / 255, 111 / 255, 146 / 255)
                        cr.arc(center.x, center.y, radius, -Math.PI / 2, -Math.PI / 2 + val * 2 * Math.PI)
                        cr.setLineWidth(5)
                        cr.setLineCap(1) // 1 = Cairo.LineCap.ROUND
                        cr.stroke()
                    })
                    cpu.subscribe(() => self.queue_draw())
                }}
            />
            <box orientation={Gtk.Orientation.VERTICAL} halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER} $type="overlay">
                <label label="CPU" class="cpu-title" />
                <label
                    label={cpu(v => `${v}%`)}
                    class="cpu-label"
                />
            </box>
        </overlay>
    )
}
