return {

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					"lua_ls",
					"vtsls",
					"html",
					"cssls",
					"cssmodules_ls",
					"css_variables",
					"somesass_ls",
					"vue_ls",
					"eslint",
					"stylelint_lsp",
					"stylua",
				},
			})
		end,
	},
}
