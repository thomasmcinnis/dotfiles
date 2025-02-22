---@module 'snacks'
return {
	{ -- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
		event = "VeryLazy",
	},
	{ -- Better folding based on treesitter nodes
		-- NOTE:
		-- for fold settings see /config/settings.lua
		-- for fold icon in statusline see /plugins/snacks.lua
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
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
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
		keys = {
			{ "<leader>st", function() Snacks.picker.todo_comments() end,                                          desc = "Todo" },
			{ "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
		},
	},
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		opts = {
			enabled = false,
			indent = { highlight = { "Whitespace" }, char = "▏" },
			scope = { enabled = false },
		},
		keys = {
			{ "<leader>ui", "<cmd>IBLToggle<CR>", desc = "Toggle indent line" },
		}
	},
	{ -- Helpful navigable file map to traverse the lsp tree
		"hedyhli/outline.nvim",
		keys = {
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Show [O]utline" }
		},
		opts = {},
	},
}
