return {
	"stevearc/conform.nvim",
	enabled = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2", "-ci" }, -- 2 пробела и авто-отступ для case/esac
				},
			},

			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},

			notify_on_error = true,
			formatters_by_ft = {
				lua = { "stylua" },
				json = { "eslint" },
				vue = { "stylelint" },
				javascript = { "eslint" },
				typescript = { "eslint" },
				html = { "eslint" },
				css = { "stylelint" },
				scss = { "stylelint" },
				yaml = { "eslint" },
				markdown = { "eslint" },
			},
		})
	end,
}
