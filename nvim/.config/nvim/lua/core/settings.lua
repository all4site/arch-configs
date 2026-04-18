-- ==========================================
-- 1. БАЗОВЫЕ НАСТРОЙКИ (ОПЦИИ)
-- ==========================================

-- Внешний вид и поведение
vim.opt.number = true -- Показывать номера строк
vim.opt.relativenumber = true -- Относительные номера строк (удобно для навигации, например, 5j или 3k)
vim.opt.showmode = false -- Не показывать режим (INSERT/NORMAL) внизу, т.к. обычно за это отвечает статуслайн (например, lualine)
vim.opt.cursorline = true -- Подсветка строки с курсором
vim.opt.termguicolors = true -- Включение полноцветной поддержки (True Color) для красивых тем
vim.opt.wrap = false -- Отключить перенос длинных строк
vim.opt.linebreak = true -- Если wrap=true, переносить по словам, а не по буквам
vim.opt.signcolumn = "yes" -- Всегда показывать колонку слева (для git signs, ошибок LSP), чтобы текст не прыгал
vim.opt.scrolloff = 8 -- Всегда оставлять 8 строк сверху и снизу от курсора при прокрутке
vim.opt.cmdheight = 0 -- Скрыть командную строку, когда она не используется (фича Neovim 0.8+)

-- Системные и рабочие настройки
vim.opt.updatetime = 300 -- Время в мс до записи в swap и срабатывания CursorHold (улучшает отзывчивость плагинов)
vim.opt.timeout = true -- Включить таймаут для комбинаций клавиш
vim.opt.timeoutlen = 500 -- Время ожидания следующей клавиши в комбинации (500 мс)
vim.opt.undofile = true -- Сохранять историю отмены (undo) даже после закрытия файла
vim.opt.swapfile = false -- Отключить создание .swp файлов (в наше время с git и undofile они редко нужны)
vim.opt.shell = "/bin/zsh" -- Использовать zsh в качестве оболочки
vim.opt.virtualedit = "block" -- Позволяет курсору двигаться туда, где нет текста, в визуальном блочном режиме (Ctrl+V)
vim.opt.clipboard = "unnamedplus" -- Использовать системный буфер обмена (позволяет копировать из Neovim в браузер и наоборот)
vim.opt.mouse = "a" -- Включить поддержку мыши во всех режимах
vim.opt.mousefocus = true -- Фокус окна при наведении мыши

-- Окна (Splits)
vim.opt.splitbelow = true -- Новые горизонтальные сплиты открываются снизу
vim.opt.splitright = true -- Новые вертикальные сплиты открываются справа

-- Отступы (Indentation)
vim.opt.expandtab = true -- Преобразовывать табы в пробелы
vim.opt.shiftwidth = 4 -- Количество пробелов для отступов (>>)
vim.opt.tabstop = 4 -- Количество пробелов, которым равен символ табуляции
vim.opt.softtabstop = 4 -- Количество пробелов при нажатии Tab/Backspace
vim.opt.smartindent = true -- Умные автоотступы при написании кода
vim.opt.formatoptions = "qrn1" -- Настройки форматирования текста (q - форматировать комменты 'gq', r - вставлять '*' после Enter)

-- Короткие сообщения
vim.opt.shortmess:append("c") -- Не показывать сообщения автодополнения (ins-completion-menu)

-- Символы-заполнители
vim.opt.fillchars = {
	vert = "│",
	fold = "⠀",
	eob = " ", -- Скрыть тильды (~) в конце пустого буфера
	msgsep = "‾",
	foldopen = "▾",
	foldsep = "│",
	foldclose = "▸",
}

-- Сессии
vim.opt.sessionoptions =
	{ "blank", "buffers", "curdir", "folds", "help", "tabpages", "winsize", "winpos", "terminal", "localoptions" }

-- ==========================================
-- 2. НАСТРОЙКИ ПЛАГИНОВ (До загрузки)
-- ==========================================
vim.diagnostic.config({ virtual_text = false }) -- Отключение виртуального текста ошибок (полезно, если он загромождает код)

-- ==========================================
-- 3. АВТОКОМАНДЫ (Autocommands)
-- ==========================================

-- 3.1 Подсветка скопированного текста (нативный Lua подход)
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	desc = "Подсветка скопированного текста",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})

-- 3.2 Отключение автоматического добавления комментариев на новой строке
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("DisableAutoComment", { clear = true }),
	desc = "Отключение автоматического комментирования при переходе на новую строку (Enter/o/O)",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- 3.3 Открытие Neotree (или другого дерева) при старте
-- Примечание: Если ты открываешь конкретный файл (nvim file.txt), дерево может перекрыть его.
-- Позже мы можем настроить это умнее, если потребуется.
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	group = vim.api.nvim_create_augroup("OpenExplorer", { clear = true }),
-- 	desc = "Открыть файловое дерево при запуске Neovim",
-- 	command = "Neotree toggle",
-- })
