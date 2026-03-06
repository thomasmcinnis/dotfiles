return {
	{
		"Olical/conjure",
		enabled = true,
		ft = { "racket", "scheme", "sicp", "clojure" },
		lazy = true,
		init = function()
			-- for scheme we use a guile socket, requires starting a guile repl at the relative path below
			-- then connect with :ConjurConnect
			vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
			vim.g["conjure#client#guile#socket#pipename"] = "./.guile-repl.socket"
			vim.g['conjure#client#guile#socket#enable_completions'] = true

			vim.g["conjure#mapping#doc_word"] = false
			vim.g["conjure#log#hud#border"] = "rounded"
			vim.g["conjure#log#hud#anchor"] = "SE"
			vim.g["conjure#log#hud#width"] = 0.4
			vim.g["conjure#log#hud#height"] = 0.3
			vim.g["conjure#log#hud#enabled"] = true
			vim.g["conjure#highlight#enabled"] = true
			vim.g["conjure#log#strip-ansi-escape-sequences-line-limit"] = 0
			vim.g["conjure#log#wrap"] = true
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
