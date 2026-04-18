-- Выполняем автоимпорты и сохраняем файл, когда изменения были зафиксированы
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("TS_add_missing_imports", { clear = true }),
	pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
	callback = function()
		-- Выполняем добавление автоимпортов
		vim.defer_fn(function()
			vim.cmd([[TSAddAutoImports]])
		end, 400)

		vim.defer_fn(function()
			-- После того, как автоимпорты добавлены, сохраняем файл
			vim.cmd("wa")
		end, 1500)
	end,
})

vim.api.nvim_create_user_command("Format", function(args)
	-- local range = nil
	-- if args.count ~= -1 then
	-- 	local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
	-- 	range = {
	-- 		start = { args.line1, 0 },
	-- 		["end"] = { args.line2, end_line and end_line:len() or 0 },
	-- 	}
	-- end

	-- Сохраняем позицию курсора
	local pos = vim.api.nvim_win_get_cursor(0)

	-- Запускаем форматирование
	vim.lsp.buf.format({
		timeout_ms = 3000,
	})

	-- Отложенное восстановление позиции курсора
	vim.defer_fn(function()
		pcall(vim.api.nvim_win_set_cursor, 0, pos)
	end, 30) -- 30ms — примерно достаточно, чтобы edits применились

	-- require("conform").format({
	-- 	async = true,
	-- 	lsp_fallback = true,
	-- 	range = range,
	-- })
end, { range = true, desc = "Format current buffer" })

--Remove unused imports
vim.api.nvim_create_user_command("TSRemoveUnusedImports", function()
	vim.lsp.buf.code_action({ apply = true, context = { only = { "source.removeUnused.ts" }, diagnostics = {} } })
end, { desc = "Remove unused imports in TypeScript files" })

--Add auto imports
vim.api.nvim_create_user_command("TSAddAutoImports", function()
	vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" }, diagnostics = {} } })
end, { desc = "Add auto imports in TypeScript files" })

--Rename files
vim.api.nvim_create_user_command("TSRenameFiles", function()
	vim.lsp.buf.code_action({ apply = true, context = { only = { "typescript.applyRenameFile" }, diagnostics = {} } })
end, { desc = "Rename in TypeScript files" })

-- Save session on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
	pattern = "*",
	callback = function()
		vim.cmd("SessionSave")
	end,
})

-- Функция для запуска ESLint
local function run_eslint_on_vue()
	local bufnr = vim.api.nvim_get_current_buf()
	local filename = vim.api.nvim_buf_get_name(bufnr)

	-- Сначала проверяем наличие ошибок с помощью eslint_d
	local check_cmd = string.format("eslint_d %s", vim.fn.shellescape(filename))
	local check_output = vim.fn.system(check_cmd)
	local has_errors = vim.v.shell_error ~= 0

	-- Запускаем --fix только если есть ошибки
	if has_errors then
		local cmd = string.format("eslint_d --fix %s", vim.fn.shellescape(filename))
		local output = vim.fn.system(cmd)
		local exit_code = vim.v.shell_error

		if exit_code == 0 then
			-- Обновляем содержимое буфера
			local success = pcall(function()
				local lines = vim.fn.readfile(filename)
				vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
			end)

			if not success then
				vim.cmd("silent! edit!")
			end
		end

		return exit_code == 0
	else
		-- Нет ошибок, ничего не делаем
		return true
	end
end

-- Создаем команду
vim.api.nvim_create_user_command("EslintFix", run_eslint_on_vue, {})

-- 1. Основная функция
local function goto_definition_with_deps()
	local builtin = require("telescope.builtin")

	-- Шаблоны файлов, которые нужно предварительно загрузить
	local patterns = {
		"./app/assets/styles/**/*.scss",
		"./types/*.ts",
		-- Добавляй сюда другие пути при необходимости
	}

	local files = {}

	-- Сбор всех файлов по шаблонам
	for _, pattern in ipairs(patterns) do
		local matched = vim.fn.glob(pattern, true, true)
		for _, file in ipairs(matched) do
			table.insert(files, file)
		end
	end

	-- Загружаем буферы
	for _, file in ipairs(files) do
		if vim.fn.filereadable(file) == 1 then
			local bufnr = vim.fn.bufadd(file)
			vim.fn.bufload(bufnr)
		end
	end
end

-- 2. Регистрация команды в Neovim
vim.api.nvim_create_user_command("IndexinFiles", goto_definition_with_deps, {})
