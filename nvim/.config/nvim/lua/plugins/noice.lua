return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		lsp = {
			-- Настройка Signature Help (чтобы не перекрывала код)
			signature = {
				enabled = true,
				auto_open = {
					enabled = true,
					trigger = true,
				},
			},
			-- Улучшенная обработка документации
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		-- Основные настройки отображения
		views = {
			cmdline_popup = {
				position = {
					row = 5,
					col = "50%",
				},
				size = {
					width = 40,
					height = "auto",
				},
				border = {
					style = "rounded", -- Закругленные углы под твой сетап
				},
			},
		},
		presets = {
			-- ВАЖНО: false переносит / и ? в popup по центру
			bottom_search = false,
			-- Делает :command более компактным и стильным
			command_palette = true,
			long_message_to_split = true,
			-- Добавляет рамки к документации LSP
			lsp_doc_border = true,
		},
	},
}
