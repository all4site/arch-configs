local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

return {
	"neovim/nvim-lspconfig",
	config = function()
		local vue_language_server_path = vim.fn.stdpath("data")
			.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

		vim.lsp.config("vtsls", {
			filetypes = { "vue", "javascript", "javascriptreact", "typescript", "typescriptreact" },
			capabilities = capabilities,
			settings = {
				vtsls = {
					tsserver = {
						preferences = {
							importModuleSpecifier = "non-relative",
							importModuleSpecifierPreference = "non-relative",
						},
						globalPlugins = {
							{
								name = "@vue/typescript-plugin",
								location = vue_language_server_path,
								languages = { "vue" },
								configNamespace = "typescript",
								enableForWorkspaceTypeScriptVersions = true,
							},
						},
					},
				},
			},
		})

		vim.lsp.config("cssls", {
			filetypes = { "css", "scss", "sass" },
			capabilities = capabilities,
		})

		vim.lsp.config("cssmodules_ls", {
			filetypes = { "javascriptreact", "typescriptreact" },
			capabilities = capabilities,
		})

		vim.lsp.config("css_variables", {
			filetypes = { "css", "scss", "less" },
			capabilities = capabilities,
		})

		vim.lsp.config("somesass_ls", {
			filetypes = { "scss", "less", "vue" },
			capabilities = capabilities,
		})

		vim.lsp.config("emmet_language_server", {
			filetypes = { "typescriptreact", "html", "vue" },
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		local base_on_attach = vim.lsp.config.eslint.on_attach
		vim.lsp.config("eslint", {
			on_attach = function(client, bufnr)
				if not base_on_attach then
					return
				end
				base_on_attach(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "LspEslintFixAll",
				})
			end,
		})

		vim.lsp.config("stylelint_lsp", {
			settings = {
				stylelintplus = {
					autoFixOnFormat = true,
					autoFixOnSave = true,
					validateOnType = true,
				},
			},
		})
	end,
}
