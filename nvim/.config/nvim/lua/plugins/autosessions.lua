return {
	"rmagatti/auto-session",
	lazy = false,
	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		-- log_level = 'debug',

		bypass_session_save_file_types = { "neo-tree" },

		pre_save_cmds = {
			"Neotree close",
			-- function()
			--     require("neo-tree.sources.manager").close_all()
			--     -- vim.notify("closed all")
			-- end,
		},
	},
}
