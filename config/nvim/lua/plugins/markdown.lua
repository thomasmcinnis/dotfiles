return {
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
		enabled = true,
		ft = { 'markdown', 'codecompanion' },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			completions = { blink = { enabled = true } },
			preset = "obsidian",
			heading = { enabled = false },
			sign = { enabled = false },
			link = { enabled = false },
			bullet = { enabled = false },
			checkbox = { enabled = false },
		}
	},
	{
		'preservim/vim-pencil',
		config = function()
			vim.keymap.set('n', '<Leader>uw', ':SoftPencil<CR>', { desc = "Toggle soft wrap", silent = true })
		end
	}
}
