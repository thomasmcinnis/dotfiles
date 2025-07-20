return {
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			update_interval = 1000,
			set_dark_mode = function()
				vim.api.nvim_set_option_value("background", "dark", {})
				vim.cmd("colorscheme kanagawa")
			end,
			set_light_mode = function()
				vim.api.nvim_set_option_value("background", "light", {})
				vim.cmd("colorscheme github_light")
			end,
		},
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = false,
			undercurl = false,
			theme = "wave",
			colors = {
				pallete = {
					samuraiRed = "#E0594C",
				},
				theme = {
					all = {
						ui = {
							bg_gutter = "none"
						},
					}
				}
			},
			overrides = function(colors)
				local theme = colors.theme

				local makeDiagnosticColor = function(color)
					local c = require("kanagawa.lib.color")
					return { fg = color, bg = c(color):blend(theme.ui.bg, 0.70):to_hex() }
				end

				return {
					NormalFloat                = { bg = "none" },
					FloatBorder                = { bg = "none" },
					FloatTitle                 = { bg = "none" },
					Pmenu                      = { bg = theme.ui.bg_dim }, -- add `blend = vim.o.pumblend` to enable transparency
					PmenuSel                   = { fg = "none", bg = theme.ui.bg_p2 },
					PmenuSbar                  = { bg = theme.ui.bg_m1 },
					PmenuThumb                 = { bg = theme.ui.bg_p1 },
					DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
					DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
					DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
					DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

					-- Save an hlgroup with dark background and dimmed foreground
					-- so that you can use it where your still want darker windows.
					-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
					-- NormalDark                 = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

					-- Popular plugins that open floats will link to NormalFloat by default;
					-- set their background accordingly if you wish to keep them dark and borderless
					-- LazyNormal                 = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					-- MasonNormal                = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				}
			end,
		},
	},
	{ 'projekt0n/github-nvim-theme', name = 'github-theme' }
}
