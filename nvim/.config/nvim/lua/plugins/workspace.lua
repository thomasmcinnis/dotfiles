return {
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- signs = {
			--   add = { text = '+' },
			--   change = { text = '~' },
			--   delete = { text = '_' },
			--   topdelete = { text = '‾' },
			--   changedelete = { text = '~' },
			-- },
		},
	},
	{ -- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{ -- Better folding based on treesitter nodes
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		opts = {
			---@diagnostic disable-next-line: unused-local
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		},
	},
	{ -- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {
			indent = { char = "▏" },
			scope = {
				enabled = false,
			},
		},
	},
	{ -- Neo-tree is a Neovim plugin to browse the file system
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>e", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
		},
		opts = {
			filesystem = {
				window = {
					position = "current",
					mappings = {
						["\\"] = "close_window",
					},
				},
			},
		},
	},
	{
		"hedyhli/outline.nvim",
		config = function()
			-- Example mapping to toggle outline
			vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

			require("outline").setup({})
		end,
	},
}
