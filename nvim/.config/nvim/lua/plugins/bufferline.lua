return {
	"akinsho/bufferline.nvim",
	requires = "nvim-tree/nvim-web-devicons",

	config = function()
		-- Включаем "золотой" winbar только там, где НЕ neo-tree
		vim.api.nvim_create_autocmd("BufWinEnter", {
			callback = function()
				-- Получаем конфиг текущего окна
				local win_config = vim.api.nvim_win_get_config(0)

				-- Если это плавающее окно (relative ~= "") или это neo-tree — убираем winbar
				if win_config.relative ~= "" or vim.bo.filetype == "neo-tree" then
					vim.wo.winbar = nil
				else
					vim.wo.winbar = " "
				end
			end,
		})
		local bufferline = require("bufferline")
		local p = require("rose-pine.palette")
		-- vim.print(p)

		bufferline.setup({
			highlights = {
				background = {
					bg = p.base,
				},
				buffer_selected = {
					bg = p.overlay,
					italic = true,
				},
			},
			options = {
				mode = "buffers",
				themable = true,
				indicator = {
					style = "none", -- Это полностью убирает рисование полоски
				},

				offsets = {
					{
						filetype = "neo-tree",
						padding = 0,
						separator = true,
					},
				},
				name_formatter = function(buf)
					local bufnr = buf.bufnr or buf.id
					if not bufnr or type(bufnr) ~= "number" then
						return buf.name or ""
					end

					local filepath = vim.api.nvim_buf_get_name(bufnr)
					if filepath == "" then
						return buf.name or ""
					end

					local relative_path = vim.fn.fnamemodify(filepath, ":.")

					local parts = {}
					for part in string.gmatch(relative_path, "[^/\\]+") do
						table.insert(parts, part)
					end

					local count = #parts
					local start = math.max(1, count - 2)

					local display_parts = {}
					for i = start, count do
						table.insert(display_parts, parts[i])
					end

					return table.concat(display_parts, "/")
				end,
			},
			-- highlights = {
			-- 	buffer_selected = {
			-- 		fg = "#98c379",
			-- 		bold = true,
			-- 		italic = false,
			-- 	},
			-- },
		})
	end,
}
