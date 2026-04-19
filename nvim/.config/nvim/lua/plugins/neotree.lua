return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	opts = {
		close_if_last_window = true,
		popup_border_style = "single",
		window = {
			width = 30,
			mappings = {
				["oc"] = false,
				["od"] = false,
				["og"] = false,
				["om"] = false,
				["on"] = false,
				["os"] = false,
				["ot"] = false,

				["o"] = "open",
				["b"] = "rename_basename",
				["<space>"] = false,
				["/"] = "fuzzy_sorter",
				["#"] = "fuzzy_finder",
				["a"] = {
					"add",
					config = {
						show_path = "absolute", -- "none", "relative", "absolute"
					},
				},
			},
			fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
				["<down>"] = "move_cursor_down",
				["<C-j>"] = "move_cursor_down",
				["<up>"] = "move_cursor_up",
				["<C-k>"] = "move_cursor_up",
				-- ['<key>'] = function(state, scroll_padding) ... end,
			},
		},
		default_component_configs = {
			icon = {
				folder_empty = "󰜌",
				folder_empty_open = "󰜌",
			},
			modified = { symbol = "" },
			git_status = {
				symbols = {
					added = "",
					deleted = "",
					modified = "",
					renamed = "➜",
					untracked = "",
					ignored = "◌",
					-- unstaged = " ✗",
					unstaged = "󰅚",
					staged = "✓",
					conflict = "",
				},
			},
		},
		document_symbols = {
			kinds = {
				File = { icon = "󰈙", hl = "Tag" },
				Namespace = { icon = "󰌗", hl = "Include" },
				Package = { icon = "󰏖", hl = "Label" },
				Class = { icon = "󰌗", hl = "Include" },
				Property = { icon = "󰆧", hl = "@property" },
				Enum = { icon = "󰒻", hl = "@number" },
				Function = { icon = "󰊕", hl = "Function" },
				String = { icon = "󰀬", hl = "String" },
				Number = { icon = "󰎠", hl = "Number" },
				Array = { icon = "󰅪", hl = "Type" },
				Object = { icon = "󰅩", hl = "Type" },
				Key = { icon = "󰌋", hl = "" },
				Struct = { icon = "󰌗", hl = "Type" },
				Operator = { icon = "󰆕", hl = "Operator" },
				TypeParameter = { icon = "󰊄", hl = "Type" },
				StaticMethod = { icon = "󰠄 ", hl = "Function" },
			},
		},
		-- Add this section only if you've configured source selector.
		source_selector = {
			winbar = false,
			--        statusline = true,
			sources = {
				{ source = "filesystem", display_name = " 󰉓 Files" },
				--{ source = "git_status", display_name = " 󰊢 Git" },
				--{ source = "buffers",    display_name = " 󰈙 Buf" },
			},
		},
		filesystem = {
			follow_current_file = true,
			hijack_netrw_behavior = "open_default",
			filtered_items = {
				visible = false, -- Keep hidden files visible if needed
				hide_dotfiles = false, -- Set to true to hide dotfiles
				hide_gitignored = true, -- Hide files that are git-ignored
				hide_by_name = {
					".git",
					"node_modules",
					".DS_Store",
				},
				hide_by_pattern = {
					"*.log",
					"*.bak",
				},
			},
			use_libuv_file_watcher = true,
		},
	},
}
