local lsp_capabilities = require('blink.cmp').get_lsp_capabilities()

return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					-- new keybinds to match defaults in nvim 0.11
					map("grr", "<cmd>lua vim.lsp.buf.references()<cr>", "Go to references")
					map("gri", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation")
					map("grn", vim.lsp.buf.rename, "Rename")
					map("gra", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Show Code Actions")
					map("gO", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", "Pick Document Symbols")
					map("<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help", { "i", "s" })
					map("gq", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format Buffer", { "n", "x" })

					-- my preferred binds
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
				end,
			})

			local servers = {
				html = {
					filetypes = {
						"html",
						"xhtml",
					},
				},
				cssls = {},
				marksman = {
					filetypes = { "markdown" },
				},
				volar = {},
				lua_ls = {
					settings = {
						Lua = {
							version = "LuaJIT",
						},
						diagnostics = {
							enable = true,
							-- Get the language server to recognize the globals like `vim`
							globals = { "vim", "describe" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("lua", true),
							checkThirdParty = false,
						},
					},
				},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"eslint",
				"jsonls",
			})

			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = ensure_installed,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, lsp_capabilities,
							server.capabilities or {})

						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		ft = { "typescript", "typescriptreact", "javascript", "vue" },
		opts = {
			cmd = { "typescript-language-server", "--stdio" },
		},
		config = function()
			require("typescript-tools").setup({
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
				settings = {
					tsserver_plugins = {
						"@vue/typescript-plugin",
					},
				},
				capabilities = lsp_capabilities,
			})
		end,
	},
}
