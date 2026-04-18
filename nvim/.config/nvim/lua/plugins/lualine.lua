return {
	"nvim-lualine/lualine.nvim",
	--event = "VeryLazy",
	config = function()
		-- Функция для LSP (без изменений)
		local function get_lsp_name()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			if #clients == 0 then
				return "No LSP"
			end
			return clients[1].name
		end

		require("lualine").setup({
			options = {
				theme = "rose-pine",
				component_separators = "",
				section_separators = { left = "", right = "" },
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { left = "", right = "" }, right_padding = 2 },
				},
				lualine_b = {
					-- Имя файла на фоне overlay
					{ "filename", separator = { right = "" } },
					-- Ветка на фоне surface (начало центральной полосы)
					{ "branch", icon = "" },
				},
				lualine_c = {
					-- Диффы на фоне surface
					{ "diff", colored = true },
				},
				lualine_x = {
					-- LSP на фоне surface
					{
						get_lsp_name,
						icon = " ",
						padding = { left = 1, right = 1 },
					},
					-- Диагностика на фоне surface
					{ "diagnostics" },
				},
				lualine_y = {
					-- Тип файла на фоне overlay (конец центральной полосы)
					{ "filetype", separator = { left = "" } },
				},
				lualine_z = {
					{ "location", separator = { left = "", right = "" }, left_padding = 2 },
				},
			},
		})
	end,
}

