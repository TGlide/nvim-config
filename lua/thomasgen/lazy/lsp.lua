return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		local cmp = require('cmp')
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities())


		require("fidget").setup({})


		local mason = require("mason")
		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"tsserver",
				"eslint",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup {
						capabilities = capabilities
					}
				end,

				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup {
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "Lua 5.1" },
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								}
							}
						}
					}
				end,
			}
		})

		-- Setup specific LSPs
		local mason_registry = require('mason-registry')
		local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
				'/node_modules/@vue/language-server'

		require 'lspconfig'.tsserver.setup {
			init_options = {
				plugins = {
					{
						-- this happneed to be installed, maybe it does not need to be added manually but if it does not work then try to install it
						name = '@vue/typescript-plugin',
						location = vue_language_server_path,
						languages = { 'vue' },
					},
				},
			},
			filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'svelte' },
			commands = {
				OrganizeImports = {
					function()
						local params = {
							command = "_typescript.organizeImports",
							arguments = { vim.api.nvim_buf_get_name(0) },
							title = ""
						}
						vim.lsp.buf.execute_command(params)
					end,
					description = "Organize Imports"
				}
			},
		}
		require 'lspconfig'.volar.setup {}


		-- Make Svelte work again
		local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
		lsp_capabilities.workspace.didChangeWatchedFiles = false
		require 'lspconfig'.svelte.setup {
			capabilities = lsp_capabilities
		}

		-- CMP
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
				['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
				['<C-y>'] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' }, -- For luasnip users.
			}, {
				{ name = 'buffer' },
			}),
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})


		-- Borders
		vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
			vim.lsp.handlers.hover,
			{ border = 'rounded' }
		)

		vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
			vim.lsp.handlers.signature_help,
			{ border = 'rounded' }
		)
	end
}
