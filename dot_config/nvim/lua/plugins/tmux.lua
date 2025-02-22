return {
	'alexghergh/nvim-tmux-navigation',
	config = function()
		require 'nvim-tmux-navigation'.setup {
			disable_when_zoomed = true,
			keybindings = {
				left = "<C-H>",
				down = "<C-J>",
				up = "<C-K>",
				right = "<C-L>",
			}
		}
	end
}
