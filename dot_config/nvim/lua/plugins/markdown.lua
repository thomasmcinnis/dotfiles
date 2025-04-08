return {
	'MeanderingProgrammer/render-markdown.nvim',
	dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
	enabled = false,
	opts = {
		preset = "lazy",
		code = {
			disable_background = true,
			language_name = false,
			-- position = "right",
			-- border = "thin",
		}
	}
}
