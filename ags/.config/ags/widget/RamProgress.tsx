import { createPoll } from "ags/time"
import { Gtk } from "ags/gtk4"
import { exec } from "ags/process"
import { Accessor } from "gnim"
import { PROGRESS_LINE_WIDTH, PROGRESS_SIZE } from "../helpers/constants"

export function RamProgress() {
    const ram = createPoll({ used: "0", total: "0", percent: 0 }, 5000, () => {
        try {
            const out = exec("free -m")
            const lines = out.split("\n")
            const memLine = lines[1].split(/\s+/)
            const totalMB = parseInt(memLine[1])
            const usedMB = parseInt(memLine[2])
            return {
                used: (usedMB / 1024).toFixed(1),
                total: (totalMB / 1024).toFixed(1),
                percent: Math.round((usedMB / totalMB) * 100)
            }
        } catch {
            return { used: "0", total: "0", percent: 0 }
        }
    }) as Accessor<{ used: string, total: string, percent: number }>

    return (
        <overlay class="ram-progress-container">
            <drawingarea
                class="ram-progress-draw"
                $={(self) => {
                    self.set_size_request(PROGRESS_SIZE, PROGRESS_SIZE)
                    self.set_draw_func((area, cr, width, height) => {
                        const val = ram().percent / 100
                        const radius = Math.min(width, height) / 2 - 5
                        const center = { x: width / 2, y: height / 2 }

                        // Фон
                        cr.setSourceRGB(0.2, 0.2, 0.2)
                        cr.arc(center.x, center.y, radius, 0, 2 * Math.PI)
                        cr.setLineWidth(PROGRESS_LINE_WIDTH)
                        cr.stroke()

                        // Прогресс
                        cr.setSourceRGB(234 / 255, 154 / 255, 151 / 255) // Новый цвет
                        cr.arc(center.x, center.y, radius, -Math.PI / 2, -Math.PI / 2 + val * 2 * Math.PI)

                        cr.setLineWidth(5)
                        cr.setLineCap(1)
                        cr.stroke()
                    })
                    ram.subscribe(() => self.queue_draw())
                }}
            />
            <box orientation={Gtk.Orientation.VERTICAL} halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER} $type="overlay">
                <label label="RAM" class="ram-title" />
                <label label={ram(v => `${v.used} GB`)} class="ram-used" />
                {/* <label label={ram(v => `/ ${v.total} GB`)} class="ram-total" /> */}
            </box>
        </overlay>
    )
}

