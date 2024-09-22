return {
	"catppuccin/nvim",
	name = "catppuccin",
	-- priority = 1000,
	---@class CatppuccinOptions
	opts = {
		flavour = "mocha",
		transparent_background = true,
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
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
				},
			},
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		require("catppuccin").load()
		vim.cmd("colorscheme catppuccin")
	end,
}
