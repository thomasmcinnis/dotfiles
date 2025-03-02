return { -- Autocompletion
	{
		cmd = "Copilot",
		"zbirenbaum/copilot.lua",
		build = ":Copilot auth",
		event = "InsertEnter",
		opts = {
			suggestion = { enabled = true },
			filetypes = {
				markdown = false,
				help = true,
				["copilot-chat"] = false,
				racket = false,
				scheme = false,
			},
		},
	},
	{
		'saghen/blink.cmp',
		dependencies = {
			'rafamadriz/friendly-snippets',
			'onsails/lspkind.nvim',
			'fang2hou/blink-copilot'
		},
		version = '*',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = { preset = 'super-tab' },
			enabled = function()
				return not vim.tbl_contains({}, vim.bo.filetype)
					and vim.bo.buftype ~= "prompt"
					and vim.b.completion ~= false
			end,

			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = 'mono',
				kind_icons = {
					Copilot = "",
				},
			},
			sources = {
				default = function()
					local sources = { 'lsp', 'copilot', 'path', 'snippets' }
					if vim.bo.filetype ~= "markdown" then
						table.insert(sources, "buffer")
					end
					return sources
				end,
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					},
					cmdline = {
						-- ignores cmdline completions when executing shell commands cos it hangs in wsl
						enabled = function()
							return vim.fn.getcmdtype() ~= ':' or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
						end
					}
				}
			},
			completion = {
				list = {
					selection = { preselect = true, auto_insert = false }
				},
				ghost_text = { enabled = true },
				menu = {
					border = "none",
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } }
					}
				},
				documentation = {
					window = { border = "single" },
					auto_show = false,
					auto_show_delay_ms = 1000,
				},
				accept = {
					auto_brackets = {
						kind_resolution = {
							enabled = true,
							blocked_filetypes = { 'racket', 'typescriptreact', 'javascriptreact', 'vue' },
						},
						semantic_token_resolution = {
							enabled = true,
							blocked_filetypes = { 'java', 'racket' },
							-- How long to wait for semantic tokens to return before assuming no brackets should be added
							timeout_ms = 400,
						},
					}
				}
			},
			signature = {
				enabled = true,
				window = { border = 'none' }
			}
		},
		opts_extend = { "sources.default" }
	},
}
