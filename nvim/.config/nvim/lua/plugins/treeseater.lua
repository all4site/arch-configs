return {
	"nvim-treesitter/nvim-treesitter",
	-- ВАЖНО: новая версия не поддерживает lazy-loading
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")

		-- 1. Базовая инициализация
		ts.setup({
			-- Путь для установки парсеров (по умолчанию stdpath('data') .. '/site')
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- 2. Список необходимых парсеров (установка асинхронная)
		-- Добавь сюда языки, с которыми работаешь (Vue, TS, NestJS)
		ts.install({
			"lua",
			"vim",
			"vimdoc",
			"query",
			"typescript",
			"javascript",
			"tsx",
			"jsx",
			"vue",
			"html",
			"css",
			"scss",
			"json",
			"bash",
			"fish",
			"nix",
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TSHighlight", { clear = true }),
			callback = function(args)
				local buf = args.buf
				local ft = vim.bo[buf].filetype

				-- Игнорируем всё, что связано с neo-tree, и стандартные служебные окна
				if ft:find("neo%-tree") or ft == "lazy" or ft == "mason" or ft == "checkhealth" then
					return
				end

				-- Маппинг типов файлов на парсеры Treesitter
				local ft_to_lang = {
					typescriptreact = "tsx",
					javascriptreact = "jsx",
				}

				local lang = ft_to_lang[ft] or vim.treesitter.language.get_lang(ft) or ft

				-- Пробуем запустить
				local ok = pcall(vim.treesitter.start, buf, lang)
				if not ok then
					-- Если не вышло, пробуем без указания языка (нативный поиск)
					pcall(vim.treesitter.start, buf)
				end
			end,
		})

		-- 4. Настройка отступов (Indentation)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "vue", "typescript", "javascript", "lua" },
			callback = function()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
