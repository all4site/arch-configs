return {

	"lewis6991/gitsigns.nvim",

	opts = {
		signs = {
			char = "│",
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "│" },
			topdelete = { text = "│" },
			changedelete = { text = "│" },
			untracked = { text = "◌" },
		},
		current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 300,
			ignore_whitespace = true,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	},
}
