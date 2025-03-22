local lsp_capabilities = require('blink.cmp').get_lsp_capabilities()
local customizations = {
	{ rule = 'style/*',   severity = 'off', fixable = true },
	{ rule = 'format/*',  severity = 'off', fixable = true },
	{ rule = '*-indent',  severity = 'off', fixable = true },
	{ rule = '*-spacing', severity = 'off', fixable = true },
	{ rule = '*-spaces',  severity = 'off', fixable = true },
	{ rule = '*-order',   severity = 'off', fixable = true },
	{ rule = '*-dangle',  severity = 'off', fixable = true },
	{ rule = '*-newline', severity = 'off', fixable = true },
	{ rule = '*quotes',   severity = 'off', fixable = true },
	{ rule = '*semi',     severity = 'off', fixable = true },
}

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
			-- If Diff mode is selected don't load any LSP Configs
			if (vim.opt.diff:get()) then
				return
			end

			vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
				local client = vim.lsp.get_client_by_id(ctx.client_id)
				if client then
					print("Hover provided by: " .. client.name)
				else
					print("Hover provider client not found")
				end
				vim.lsp.handlers.hover(err, result, ctx, config)
			end

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
					map("<leader>uI", "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>",
						"Toggle inlay hints", "n")
				end,
			})

			local servers = {
				html = {
					filetypes = {
						"html",
						"xhtml",
					},
				},
				tailwindcss = {
					filetypes = { "vue", "html" }
				},
				cssls = {},
				marksman = {
					filetypes = { "markdown" },
				},
				eslint = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
						"vue",
						"html",
						"markdown",
						"json",
						"jsonc",
						"yaml",
						"toml",
						"xml",
						"gql",
						"graphql",
						"astro",
						"svelte",
						"css",
						"less",
						"scss",
						"pcss",
						"postcss"
					},
					settings = {
						-- Silent the stylistic rules in you IDE, but still auto fix them
						rulesCustomizations = customizations,
					},
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							command = "EslintFixAll",
						})
					end
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

			require("lspconfig").racket_langserver.setup {
				capabilities = lsp_capabilities,
				filetypes = { 'racket' },
			}

			-- require("lspconfig").scheme_langserver.setup {
			-- 	capabilities = lsp_capabilities,
			-- 	filetypes = { 'scheme' },
			-- 	root_dir = function()
			-- 		return vim.fn.getcwd() -- You can modify this to specify the root directory more accurately
			-- 	end,
			-- }
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
			---@type lsp.ClientCapabilities
			local ts_capabilities = vim.deepcopy(lsp_capabilities)
			---@diagnostic disable-next-line: inject-field
			ts_capabilities.documentFormattingProvider = false
			---@diagnostic disable-next-line: inject-field
			ts_capabilities.documentRangeFormattingProvider = false

			require("typescript-tools").setup({
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
				settings = {
					tsserver_plugins = {
						"@vue/typescript-plugin",
					},
				},
				capabilities = ts_capabilities,
			})
		end,
	},
}
