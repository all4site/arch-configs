return {

	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },

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
