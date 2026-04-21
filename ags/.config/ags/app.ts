import app from "ags/gtk4/app"
import style from "./main.scss"
import Bar from "./widget/Bar"
import BarLeft from "./widget/BarLeft"

app.start({
    css: style,
    main() {
        Bar(0)
        BarLeft(1)
    },
})
