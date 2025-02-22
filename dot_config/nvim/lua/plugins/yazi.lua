return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		-- ?? in this section, choose your own keymappings!
		-- {
		-- 	"<leader>k",
		-- 	mode = { "n", "v" },
		-- 	"<cmd>Yazi<cr>",
		-- 	desc = "Open yazi at the current file",
		-- },
		{
			-- Open in the current working directory
			"<leader>k",
			"<cmd>Yazi cwd<cr>",
			desc = "Open the file manager in nvim's working directory",
		},
		{
			"<leader>@", -- this is leader and layer1+e on my split keyboard which is like tapping space, then holding space and tapping e
			"<cmd>Yazi toggle<cr>",
			desc = "Resume the last yazi session",
		},
	},
	opts = {
		open_for_directories = false,
		keymaps = {
			show_help = "<f1>",
		},
		floating_window_scaling_factor = 1, -- fill the screen rather than leave space around
		yazi_floating_window_border = "none", -- no border so it looks like a full screen
	},
}
