import app from "ags/gtk4/app"
import style from "./main.scss"
import Bar from "./widget/Bar"
import BarLeft from "./widget/BarLeft"
import Dash from "./windows/dash"

app.start({
    css: style,
    main() {
        Bar(1)
        BarLeft(0)
        Dash(1)
    },
})
