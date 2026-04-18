return {
	-- "navarasu/onedark.nvim",
	"rose-pine/neovim",
	lazy = false,
	config = function()
		require("rose-pine").setup({
			transparent = true,
			highlight_groups = {
				-- WinBar
				WinBar = { bg = "base" },
				WinBarNC = { bg = "base" },

				-- Buffer
				BufferLineFill = { bg = "base" },

				BufferLineBackground = { fg = "muted", bg = "base" },
				BufferLineBufferSelected = {
					fg = "rose", -- Цвет текста (сделаем темным для контраста)
					bg = "overlay", -- Цвет фона вкладки (например, бирюзовый "foam")
					bold = false, -- Сделать текст жирным
				},

				-- Кнопка закрытия (крестик) на активной вкладке
				BufferLineCloseButtonSelected = { fg = "text", bg = "overlay" },
				BufferLineCloseButton = { fg = "muted", bg = "base" },

				-- Разделители (чтобы не было пустых дырок между табами)
				BufferLineSeparatorSelected = { fg = "base", bg = "overlay" },
				BufferLineSeparator = { fg = "base", bg = "base" },

				--  Индикатор (полоска слева/снизу, если она есть)
				BufferLineIndicatorSelected = { fg = "foam", bg = "overlay" },
				BufferLineIndicator = { fg = "foam", bg = "base" },

				-- Если нужно, чтобы Neo-tree тоже подкрашивался в тон:
				BufferLineOffsetSeparator = { fg = "muted", bg = "base" },
			},
		})
		vim.cmd("colorscheme rose-pine-moon")
	end,
}
