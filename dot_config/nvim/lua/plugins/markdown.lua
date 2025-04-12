return {
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
		enabled = true,
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
			links = { enabled = false },
			bullet = { enabled = false },
			checkboxes = { enabled = false },

		}
	},
	{
		'preservim/vim-pencil'
	}
}
