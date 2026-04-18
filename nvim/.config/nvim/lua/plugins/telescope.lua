return {

	"nvim-telescope/telescope.nvim",
	tag = "0.1.2",
	dependencies = { "nvim-lua/plenary.nvim" },

	opts = {
		defaults = {
			layout_strategy = "horizontal",
			sorting_strategy = "ascending",
			layout_config = {
				prompt_position = "top",
			},

			file_ignore_patterns = {
				"node_modules",
				"dist",
				"build",
				".git",
				".DS_Store",
				"package%-lock.json",
			},
		},
	},
}

