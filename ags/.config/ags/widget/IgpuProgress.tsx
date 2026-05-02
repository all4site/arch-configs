import { createPoll } from "ags/time"
import { Gtk } from "ags/gtk4"
import { exec } from "ags/process"
import { Accessor } from "gnim"
import { PROGRESS_LINE_WIDTH, PROGRESS_SIZE } from "../helpers/constants"

export function IgpuProgress() {
    const igpu = createPoll(0, 2000,
        () => {
            try {
                const out = exec("intel_gpu_top -J -n 1")
                const data = JSON.parse(out)
                const busy = data[0]?.engines?.["Render/3D"]?.busy || 0
                return Math.round(busy)
            } catch (e) {
                return 0
            }
        }
    ) as Accessor<number>

    return (
        <overlay class="igpu-progress-container" halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}>
            <drawingarea
                class="igpu-progress-draw"
                $={(self) => {
                    self.set_size_request(PROGRESS_SIZE, PROGRESS_SIZE)
                    self.set_draw_func((area, cr, width, height) => {
                        const val = igpu() / 100
                        const radius = Math.min(width, height) / 2 - 5
                        const center = { x: width / 2, y: height / 2 }

                        // Фон
                        cr.setSourceRGB(0.2, 0.2, 0.2)
                        cr.arc(center.x, center.y, radius, 0, 2 * Math.PI)
                        cr.setLineWidth(PROGRESS_LINE_WIDTH)
                        cr.stroke()

                        // Прогресс
                        cr.setSourceRGB(135 / 255, 206 / 255, 235 / 255)
                        cr.arc(center.x, center.y, radius, -Math.PI / 2, -Math.PI / 2 + val * 2 * Math.PI)
                        cr.setLineWidth(5)
                        cr.setLineCap(1)
                        cr.stroke()
                    })
                    igpu.subscribe(() => self.queue_draw())
                }}
            />
            <box orientation={Gtk.Orientation.VERTICAL} halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER} $type="overlay">
                <label label="iGPU" class="igpu-title" />
                <label
                    label={igpu(v => `${v}%`)}
                    class="igpu-label"
                />
            </box>
        </overlay>
    )
}
