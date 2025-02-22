return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			local opts = {
				transparent_background = false,
				default_integrations = true,
				integrations = {
					blink_cmp = true,
					snacks = true,
					which_key = true,
				}
			}
			require("catppuccin").setup(opts)
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	{ "rose-pine/neovim", name = "rose-pine" },
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		opts = {
			transparent = false,
		}
	},
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	}
}
