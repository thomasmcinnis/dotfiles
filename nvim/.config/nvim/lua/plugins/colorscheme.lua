return {
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			update_interval = 1000,
			set_dark_mode = function()
				vim.api.nvim_set_option_value("background", "dark", {})
				-- vim.cmd("colorscheme gruvbox")
			end,
			set_light_mode = function()
				vim.api.nvim_set_option_value("background", "light", {})
				-- vim.cmd("colorscheme gruvbox")
			end,
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		-- priority = 1000,
		---@class CatppuccinOptions
		opts = {
			flavour = "auto",
			background = {
				light = "latte",
				dark = "mocha",
			},
			no_underline = true,
			no_italic = true,
			transparent_background = false,
			highlight_overrides = {
				all = function(colors)
					return {
						NormalFloat = { bg = colors.base },
						FloatBorder = { bg = colors.base },
						NeoTreeNormal = { bg = colors.base },
					}
				end,
				latte = function(colors)
					return {
						LineNr = { fg = colors.overlay2 },
					}
				end,
			},
			color_overrides = {
				latte = {
					base = "#fafaf9", -- tw-stone-50 (unchanged)
					surface0 = "#f7f7f6", -- Slightly more contrast
					surface1 = "#f4f4f3", -- Slightly more contrast
					surface2 = "#f1f1f0", -- Slightly more contrast
					mantle = "#eeeeec", -- Slightly more contrast
					crust = "#ebebea", -- Slightly more contrast
					overlay0 = "#e7e7e4",
					overlay1 = "#d6d3d1",
					overlay2 = "#a8a29e",
					text = "#292524",
					subtext1 = "#44403c",
					subtext0 = "#57534e",
					rosewater = "#543D4F",
					flamingo = "#ca3f6a",
					red = "#872744",
					maroon = "#793252",
					pink = "#803449",
					mauve = "#564858",
					peach = "#843840",
					yellow = "#7d5424",
					green = "#31473c",
					teal = "#284542",
					sky = "#254248",
					sapphire = "#25414a",
					blue = "#2c3d4c",
					lavender = "#35384a",
				},
			},
			integrations = {
				alpha = true,
				cmp = true,
				dap = {
					enabled = true,
					enable_ui = true, -- enable nvim-dap-ui
				},
				fidget = true,
				flash = true,
				gitsigns = true,
				harpoon = true,
				lsp_trouble = true,
				mason = true,
				neotree = true,
				neotest = true,
				noice = true,
				navic = {
					enabled = true,
					custom_bg = "NONE", -- "lualine" will set background to mantle
				},
				notify = true,
				octo = true,
				overseer = true,
				telescope = {
					enabled = true,
				},
				treesitter = true,
				treesitter_context = false,
				symbols_outline = true,
				illuminate = true,
				which_key = true,
				barbecue = {
					dim_dirname = true,
					bold_basename = true,
					dim_context = false,
					alt_background = false,
				},
				native_lsp = {
					enabled = true,
				},
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			require("catppuccin").load()
			vim.cmd("colorscheme catppuccin")
		end,
	},
}
