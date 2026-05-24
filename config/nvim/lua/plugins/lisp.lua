return {
	{
		"Olical/conjure",
		enabled = true,
		ft = { "racket", "scheme", "sicp", "clojure" },
		lazy = true,
		init = function()
			vim.g["conjure#mapping#doc_word"] = false
			vim.g["conjure#log#hud#border"] = "single"
			vim.g["conjure#log#hud#anchor"] = "SE"
			vim.g["conjure#log#hud#width"] = 0.3 
			vim.g["conjure#eval#inline_results"] = true 
			vim.g["conjure#log#hud#enabled"] = true
			vim.g["conjure#highlight#enabled"] = true
			vim.g["conjure#log#split#height"] = 0.2
			vim.g["conjure#log#wrap"] = true
			vim.g["conjure#log#botright"] = true
		end,
	},
	{
		"julienvincent/nvim-paredit",
		ft = { "racket", "scheme", "sicp", "clojure" },
		config = function()
			require("nvim-paredit").setup()
		end
	},
	{
		"gpanders/nvim-parinfer",
		ft = { "racket", "scheme", "sicp", "clojure" },
	},
}
