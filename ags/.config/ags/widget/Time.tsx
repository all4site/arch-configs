import { createPoll } from "ags/time"
import { Accessor } from "gnim"

export function Time() {

    const time = createPoll("", 1000, () => {
        const date = new Date();

        // Создаем форматтер для английского языка
        const formatter = new Intl.DateTimeFormat('en-US', {
            weekday: 'short',
            month: '2-digit',
            day: '2-digit',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
            hour12: false
        });

        // Разбиваем дату на части
        const parts = formatter.formatToParts(date);

        // Извлекаем нужные значения по типам
        const p = (type: string) => parts.find(part => part.type === type)?.value || "";

        return `${p('weekday')} ${p('day')}.${p('month')} ${p('year')} ${p('hour')}:${p('minute')}`.toUpperCase();

    }) as Accessor<string>


    return (
        <menubutton>
            <label label={time} />
        </menubutton>
    )
}
