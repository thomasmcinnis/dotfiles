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

				return {
					NormalFloat                = { bg = "none" },
					FloatBorder                = { bg = "none" },
					FloatTitle                 = { bg = "none" },
					Pmenu                      = { bg = theme.ui.bg_dim }, -- add `blend = vim.o.pumblend` to enable transparency
					PmenuSel                   = { fg = "none", bg = theme.ui.bg_p2 },
					PmenuSbar                  = { bg = theme.ui.bg_m1 },
					PmenuThumb                 = { bg = theme.ui.bg_p1 },
				}
			end,
		},
	},
	{ 'projekt0n/github-nvim-theme', name = 'github-theme' }
}
