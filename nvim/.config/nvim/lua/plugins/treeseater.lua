return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"css",
				"scss",
				"html",
				"javascript",
				"typescript",
				"tsx",
			},

			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			context_commentstring = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Enter>", -- Инициализировать выделение (Enter)
					node_incremental = "<Enter>", -- Увеличить выделение (на один узел дерева выше)
					scope_incremental = "<Tab>", -- Увеличить до ближайшей области видимости (scope)
					node_decremental = "<BS>", -- Уменьшить выделение (Backspace)
				},
			},
		})
	end,
}
