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
				automatic_enable = true,
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
}
