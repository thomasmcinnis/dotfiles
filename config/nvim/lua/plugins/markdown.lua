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
			code = {
				position = 'right',
				width = 'block',
				border = 'thick',
				min_width = 45,
				language_pad = 2,
				left_pad = 2,
				right_pad = 4,
			},
			heading = {
				enabled = false,
				width = 'block',
				min_width = 80,
				position = 'inline'
			},
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
