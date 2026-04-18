vim.g.mapleader = " "
function switchNeotree()
	if vim.bo.filetype == "neo-tree" then
		vim.cmd.wincmd("p")
	else
		vim.cmd.Neotree("focus")
	end
end
--Search and replace
vim.keymap.set("n", "<leader>rs", function()
	-- Получаем слово под курсором
	local word = vim.fn.expand("<cword>")
	-- Создаем команду замены с этим словом
	local cmd = ":s/" .. word .. "/" .. "/g<Left><Left>"
	-- Выполняем команду
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), "n", false)
end, { desc = "Replace word under cursor in line", noremap = true, silent = true })

vim.keymap.set("n", "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>", opts)
vim.keymap.set("n", "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", opts)
vim.keymap.set("n", "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", opts)
vim.keymap.set("n", "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", opts)
vim.keymap.set("n", "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>", opts)

vim.keymap.set("v", "<C-s>", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", opts)
vim.keymap.set("v", "<leader>rs", "<CMD>SearchReplaceWithinVisualSelection<CR>", opts)
vim.keymap.set("v", "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", opts)

-- Search spectre plugin
vim.keymap.set("n", "<leader>sr", '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre",
})
vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})
vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})

--Yank
vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "Yank" })

-- Buffer
vim.keymap.set("n", "<leader>c", ":bp|sp|bn|bd<CR>", { desc = "Buffer close" })
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<s-Tab>", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>bc", ":bd<CR>", { desc = "Current buffer close" })
vim.keymap.set("n", "<leader>bl", ":BufferLinePick<CR>")
vim.keymap.set("n", "<leader>bd", ":BufferLinePickClose<CR>", { desc = "Buffer pick close" })
vim.keymap.set("n", "<leader>ba", ":w|%bd|e#|bd#|NeoTreeShow<CR>", { desc = "Buffer close all except current" })
vim.keymap.set("n", "<leader>bx", ":bufdo bp|sp|bn|bd<CR>", { desc = "Close all" })

-- NeoTree
vim.keymap.set("n", "<leader>e", ":Neotree focus toggle<CR>", { desc = "Neotree focus" })
vim.keymap.set("n", "<leader>o", switchNeotree, { desc = "Switch neotree focus" })

-- Comment
vim.keymap.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
end, { desc = "Comment line" })

vim.keymap.set("n", "<leader>.", function()
	require("Comment.api").toggle.blockwise()
end, { desc = "Comment blockwise" })

vim.keymap.set(
	"v",
	"<leader>/",
	"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
	{ desc = "Comment multiple line" }
)
vim.keymap.set(
	"v",
	"<leader>.",
	"<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>",
	{ desc = "Comment multiple line" }
)
--Move lines
vim.keymap.set("n", "<A-k>", ":MoveLine(-1)<CR>", { desc = "Move line up" })
vim.keymap.set("n", "<A-j>", ":MoveLine(1)<CR>", { desc = "Move line down" })
vim.keymap.set("v", "<A-k>", ":MoveBlock(-1)<CR>", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":MoveBlock(1)<CR>", { desc = "Move line down" })

-- Navigation
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Splits
vim.keymap.set("n", "|", ":vsplit<CR>")
vim.keymap.set("n", "\\", ":split<CR>")

-- Other
vim.keymap.set("n", "<leader>w", ":wa!|e<CR>", { desc = "Write file" })
-- vim.keymap.set("n", "<leader>wa", ":wa|e<CR>", { desc = "Write file" })
vim.keymap.set("n", "<leader>q", ":q|q<CR>", { desc = "Quit" })
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<esc>", ":nohlsearch<CR>", { desc = "No highlight" })

-- Terminal
vim.keymap.set("n", "<leader>tt", ":ToggleTerm direction=float<CR>", { desc = "ToggleTerm" })
vim.keymap.set("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { desc = "ToggleTerm horizontal" })
vim.keymap.set("n", "<leader>tv", ":ToggleTerm direction=vertical size=40<CR>", { desc = "ToggleTerm vertical" })

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find word" })
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Find old files" })

-- Lazygit
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Lazygit" })

-- Hop
vim.keymap.set("n", "<leader>h", "<cmd>HopWord<cr>", { desc = "Hop word" })

--Codeium
vim.keymap.set("i", "<c-j>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true, desc = "Codeium accept" })
vim.keymap.set("i", "<c-;>", function()
	return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, desc = "Codeium next" })
vim.keymap.set("i", "<c-,>", function()
	return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, desc = "Codeium prev" })
vim.keymap.set("i", "<c-x>", function()
	return vim.fn["codeium#Clear"]()
end, { expr = true, desc = "Codeium clear" })

--Lsp
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>lr", "<cmd>TSRemoveUnusedImports<cr>", { desc = "Remove unused imports" })
vim.keymap.set("n", "<leader>la", "<cmd>TSAddAutoImports<cr>", { desc = "Add auto imports" })
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show diagnostics" })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
		-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })

		vim.keymap.set("n", "gd", function()
			local builtin = require("telescope.builtin")
			builtin.lsp_definitions()
		end, { desc = "Go to definition (telescope)" })

		-- vim.keymap.set("n", "gds", function()
		-- 	local builtin = require("telescope.builtin")
		-- 	local files = vim.fn.glob("./app/assets/styles/**/*.scss", true, true)
		--
		-- 	for _, file in ipairs(files) do
		-- 		print(file)
		-- 		if vim.fn.filereadable(file) == 1 then
		-- 			-- Создаем буфер без переключения
		-- 			local bufnr = vim.fn.bufadd(file)
		-- 			vim.fn.bufload(bufnr)
		-- 		end
		-- 	end
		-- 	builtin.lsp_definitions()
		-- end, { desc = "Go to definition scss ones" })

		vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Show declaration" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Show implementation" })
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature help" })
		vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })

		-- vim.keymap
		-- .set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { noremap = true })
		-- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
		-- opts)
		-- vim.keymap.set('n', '<leader>wl', function()
		-- print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
		-- end, opts)
		-- vim.keymap.set("n", "<leader>lD", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		-- vim.keymap.set("n", "<leader>lf", function()
		--     vim.lsp.buf.format()
		-- end, { desc = 'Format file' })
		vim.keymap.set("n", "<leader>lf", "<cmd>Format<cr>", { buffer = ev.buf, desc = "Format file" })
		vim.keymap.set("n", "<leader>lc", function()
			vim.lsp.buf.code_action()
		end, { desc = "Code action" })
		vim.keymap.set("n", "<leader>le", "<cmd>EslintFix<cr>", { desc = "Run ESLint --fix" })
	end,
})
