return {
	'saghen/blink.cmp',
	dependencies = {
		'rafamadriz/friendly-snippets',
		'onsails/lspkind.nvim',
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
		},
		sources = {
			default = function()
				local sources = { 'omni', 'snippets', 'lsp', 'path' }
				if vim.bo.filetype ~= "markdown" then
					table.insert(sources, "buffer")
				end
				return sources
			end,
			per_filetype = {
				codecompanion = { "codecompanion" },
			},
			providers = {
				-- cmdline = {
				-- 	-- ignores cmdline completions when executing shell commands cos it hangs in wsl
				-- 	enabled = function()
				-- 		return vim.fn.getcmdtype() ~= ':' or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
				-- 	end
				-- }
			}
		},
		completion = {
			list = {
				selection = { preselect = true, auto_insert = false }
			},
			ghost_text = { enabled = false },
			menu = {
				border = "single",
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } },
					components = {
						kind_icon = {
							text = function(ctx)
								local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
								return kind_icon
							end,
							-- (optional) use highlights from mini.icons
							highlight = function(ctx)
								local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
								return hl
							end,
						},
						kind = {
							-- (optional) use highlights from mini.icons
							highlight = function(ctx)
								local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
								return hl
							end,
						}
					},
				}
			},
			documentation = {
				window = { border = "single" },
				auto_show = true,
				auto_show_delay_ms = 500,
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
			enabled = false,
			window = { border = 'none' }
		}
	},
	opts_extend = { "sources.default" }
}
