return {
	{
		"Olical/conjure",
		enabled = true,
		ft = { "racket", "scheme", "sicp" },
		lazy = true,
		init = function()
			-- for scheme we use a guile socket, requires starting a guile repl at the relative path below
			-- then connect with :ConjurConnect
			vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
			vim.g["conjure#client#guile#socket#pipename"] = "./.guile-repl.socket"
			vim.g['conjure#client#guile#socket#enable_completions'] = true
		end,
	},
	{
		"kovisoft/slimv",
		enabled = true,
		ft = { "lisp" },
		lazy = true,
	},
}
