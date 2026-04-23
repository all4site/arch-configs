return {
	"gbprod/yanky.nvim",
	opts = {
		-- Опция для сохранения буфера при вставке поверх текста
		ring = {
			history_length = 100,
			storage = "shada",
			update_register_on_cycle = false,
			sync_with_numbered_registers = true,
		},
		system_clipboard = {
			sync_with_ring = false,
		},
		highlight = {
			on_put = true, -- Подсветка текста при вставке
			on_yank = true,
		},
		preserve_cursor_position = {
			enabled = true,
		},
	},
}
