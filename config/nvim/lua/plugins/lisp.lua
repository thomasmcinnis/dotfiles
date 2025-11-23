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
		init = function()
			vim.g["slimv_swank_cmd"] = "! tmux new-window -d -n REPL-SBCL \"ros run -e '(ql:quickload :swank) (swank:create-server :dont-close t)'\""
			vim.g["slimv_lisp"] = 'ros run'
			vim.g["slimv_impl"] = 'sbcl'
			vim.g["slimv_keybindings"] = 2
			vim.g["slimv_repl_split"] = 4
			vim.g["slimv_repl_split_size"] = 80
			vim.g["slimv_balloon"] = true

-- ! tmux new-window -d -n REPL-SBCL "ros run --eval '(ql:quickload :swank) (swank:create-server :dont-close t)'"
		end,
	},
}
