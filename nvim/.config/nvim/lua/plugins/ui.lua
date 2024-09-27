return {
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			require("barbecue").setup({})
		end,
	},
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	dependencies = {
	-- 		"meuter/lualine-so-fancy.nvim",
	-- 	},
	-- 	enabled = true,
	-- 	lazy = false,
	-- 	event = { "BufReadPost", "BufNewFile", "VeryLazy" },
	-- 	config = function()
	-- 		require("lualine").setup({
	-- 			options = {
	-- 				theme = "auto",
	-- 				-- theme = "catppuccin",
	-- 				globalstatus = true,
	-- 				icons_enabled = true,
	-- 				component_separators = { left = "|", right = "|" },
	-- 				section_separators = { left = "", right = "" },
	-- 				disabled_filetypes = {
	-- 					statusline = {
	-- 						"help",
	-- 						"neo-tree",
	-- 						"Trouble",
	-- 						"spectre_panel",
	-- 						"toggleterm",
	-- 					},
	-- 					winbar = {},
	-- 				},
	-- 			},
	-- 			sections = {
	-- 				lualine_a = { "mode" },
	-- 				lualine_b = {
	-- 					"fancy_branch",
	-- 					"fancy_diff",
	-- 				},
	-- 				lualine_c = {
	-- 					{
	-- 						"fancy_diagnostics",
	-- 						sources = { "nvim_lsp" },
	-- 						symbols = { error = " ", warn = " ", info = " " },
	-- 					},
	-- 					{
	-- 						"filename",
	-- 						path = 3, -- 2 for full path
	-- 						symbols = { modified = "  ", readonly = "  ", unnamed = "  " },
	-- 					},
	-- 				},
	-- 				lualine_x = {
	-- 					{ "fancy_searchcount" },
	-- 				},
	-- 				lualine_y = {
	-- 					"fancy_lsp_servers",
	-- 					"%L",
	-- 				},
	-- 				lualine_z = {},
	-- 			},
	-- 			inactive_sections = {
	-- 				lualine_a = {},
	-- 				lualine_b = {},
	-- 				lualine_c = { "filename" },
	-- 				-- lualine_x = { "location" },
	-- 				lualine_y = {},
	-- 				lualine_z = {},
	-- 			},
	-- 			tabline = {},
	-- 			extensions = { "neo-tree", "lazy" },
	-- 		})
	-- 	end,
	-- },
}
