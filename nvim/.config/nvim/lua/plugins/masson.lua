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
					-- "somesass_ls",
					"cssls",
					-- "cssmodules_ls",
					-- "css_variables",
					"vue_ls",
					"eslint",
					"stylelint_lsp",
					"stylua",
				},
			})
		end,
	},
}
