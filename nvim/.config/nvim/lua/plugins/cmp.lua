return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Источники (Sources)
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",

			-- Сниппеты: Snippy
			"dcampos/nvim-snippy",
			"dcampos/cmp-snippy",

			-- Иконки в меню
			"onsails/lspkind.nvim",
		},
		event = { "InsertEnter", "CmdlineEnter" }, -- Загружаем при входе в режим вставки или командную строку
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local snippy = require("snippy")

			-- Вспомогательная функция для корректной работы Tab
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				snippet = {
					expand = function(args)
						snippy.expand_snippet(args.body) -- Используем snippy
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					-- Настройка Tab для автодополнения и прыжков по сниппетам
					["<Tab>"] = cmp.mapping(function(fallback)
						if snippy.can_expand_or_advance() then
							-- Если можно прыгнуть по сниппету, прыгаем в первую очередь
							snippy.expand_or_advance()
						elseif cmp.visible() then
							-- Если сниппета нет, но есть меню — выбираем элемент
							cmp.select_next_item()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if snippy.can_jump(-1) then
							snippy.previous()
						elseif cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 750 },
					{ name = "snippy", priority = 1000 }, -- Приоритет сниппетов
					{ name = "nvim_lsp_signature_help" },
					{ name = "buffer", priority = 500 },
					{ name = "path", priority = 250 },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						ellipsis_char = "...",
						-- Твои кастомные иконки подхватятся здесь автоматически через lspkind
					}),
				},
			})

			-- Поиск по файлу (/)
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = { { name = "buffer" } },
			})

			-- Командная строка (:)
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
