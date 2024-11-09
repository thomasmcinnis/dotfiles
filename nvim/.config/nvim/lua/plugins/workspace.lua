return {
	{
		"tummetott/unimpaired.nvim",
		event = "VeryLazy",
		opts = {},
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
			indent = { highlight = { "Whitespace" }, char = "▏" },
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
		keys = {
			{
				"<leader>k",
				":Neotree reveal current toggle<CR>",
				{ silent = true, desc = "Browse Current Working Directory" },
			},
		},
		opts = {
			popup_border_style = "rounded",
			window = {
				mappings = {
					["h"] = "close_node",
					["l"] = "open",
					["<space>"] = "none",
				},
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
				},
				window = {
					mappings = {
						["h"] = "close_node",
						["l"] = "open",
						["<space>"] = "none",
					},
				},
			},
		},
	},
	{
		"hedyhli/outline.nvim",
		config = function()
			-- Example mapping to toggle outline
			vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Show [O]utline" })

			require("outline").setup({})
		end,
	},
}
