return {
	{
		"saghen/blink.cmp",
		version = "*",
		dependencies = {
			"L3MON4D3/LuaSnip",
		},

		opts = {
			snippets = { preset = "luasnip" },
			keymap = {
				preset = "none",
				-- Добавляем принудительный вызов меню
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

				["<Tab>"] = {
					function(cmp)
						if cmp.is_visible() then
							return cmp.select_next()
						end
						if cmp.snippet_active() then
							return cmp.snippet_forward()
						end
					end,
					"fallback",
				},
				["<S-Tab>"] = {
					function(cmp)
						if cmp.is_visible() then
							return cmp.select_prev()
						end
						if cmp.snippet_active() then
							return cmp.snippet_backward()
						end
					end,
					"fallback",
				},
				["<CR>"] = { "accept", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			completion = {
				menu = { border = "rounded", auto_show = true },
				documentation = { window = { border = "rounded" }, auto_show = true },
				trigger = {
					-- 1. Самое важное: не открывать меню "насильно" при вводе { или :
					show_on_trigger_character = false,
				},

				list = {
					selection = {
						-- 2. Не подсвечивать первый элемент.
						-- Теперь Enter внутри скобок всегда будет просто переносом строки.
						preselect = false,
						auto_insert = false,
					},
				},
			},
		},
		config = function(_, opts)
			require("luasnip.loaders.from_snipmate").lazy_load()
			require("blink.cmp").setup(opts)
		end,
	},
}
