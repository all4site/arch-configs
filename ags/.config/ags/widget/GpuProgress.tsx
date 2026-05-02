import { createPoll } from "ags/time"
import { Gtk } from "ags/gtk4"
import { Accessor } from "gnim"
import { PROGRESS_LINE_WIDTH, PROGRESS_SIZE } from "../helpers/constants"

export function GpuProgress() {
    const gpu = createPoll(0, 2000,
        "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits",
        (out) => Math.round(parseFloat(out))
    ) as Accessor<number>

    return (
        <overlay class="gpu-progress-container" >
            <drawingarea
                class="gpu-progress-draw"
                $={(self) => {
                    self.set_size_request(PROGRESS_SIZE, PROGRESS_SIZE)
                    self.set_draw_func((area, cr, width, height) => {
                        const val = gpu() / 100
                        const radius = Math.min(width, height) / 2 - 5
                        const center = { x: width / 2, y: height / 2 }

                        // Фон
                        cr.setSourceRGB(0.2, 0.2, 0.2)
                        cr.arc(center.x, center.y, radius, 0, 2 * Math.PI)
                        cr.setLineWidth(PROGRESS_LINE_WIDTH)
                        cr.stroke()

                        // Прогресс (Зеленый цвет для GPU)
                        cr.setSourceRGB(50 / 255, 205 / 255, 50 / 255)
                        cr.arc(center.x, center.y, radius, -Math.PI / 2, -Math.PI / 2 + val * 2 * Math.PI)
                        cr.setLineWidth(5)
                        cr.setLineCap(1)
                        cr.stroke()
                    })
                    gpu.subscribe(() => self.queue_draw())
                }}
            />
            <box orientation={Gtk.Orientation.VERTICAL} halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER} $type="overlay">
                <label label="GPU" class="gpu-title" />
                <label
                    label={gpu(v => `${v}%`)}
                    class="gpu-label"
                />
            </box>
        </overlay>
    )
}
