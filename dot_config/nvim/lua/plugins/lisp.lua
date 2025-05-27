return {
	{
		"Olical/conjure",
		enabled = true,
		ft = { "racket", "scheme", "sicp" },
		lazy = true,
		-- dependencies = { "wlangstroth/vim-racket" },
		init = function()
			vim.g["conjure#client#scheme#stdio#command"] = "gsi" -- "gsi -:debug=+"
			vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "%d*> " -- from racket "\n?[\"%w%-./_]*> "
			vim.g["conjure#client#scheme#stdio#value_prefix_pattern"] = false
			vim.g["conjure#log#botright"] = true
			vim.g["conjure#log#wrap"] = true
		end,
	},
	-- { "wlangstroth/vim-racket" }
}

-- " In Chicken 5.4+ you may need to remove the `-quiet` arg for it to work with Conjure.
-- let g:conjure#client#scheme#stdio#command = "csi -quiet -:c"
-- let g:conjure#client#scheme#stdio#prompt_pattern = "\n-#;%d-> "
-- let g:conjure#client#scheme#stdio#value_prefix_pattern = v:false
