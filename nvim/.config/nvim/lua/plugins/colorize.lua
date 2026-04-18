return {
	"NvChad/nvim-colorizer.lua",
	event = "BufRead",
	config = function()
		require("colorizer").setup({
			filetypes = {
				-- Здесь указываются только те файлы, где нужно включить подсветку цветов
				"html",
				"css",
				"javascript",
				"lua",
				"vim",
				"typescript",
				"scss",
				"json", -- и т.д.
			},
			user_default_options = {
				tailwind = true,
				-- mode = "foreground"
				mode = "background",
			},
		})
	end,
}
