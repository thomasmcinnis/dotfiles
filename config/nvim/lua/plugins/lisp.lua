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
			vim.g["conjure#log#hud#width"] = 1.0
			vim.g["conjure#log#hud#height"] = 0.3
			-- vim.g["conjure#log#hud#enabled"] = true
			vim.g["conjure#highlight#enabled"] = true
			vim.g["conjure#log#strip-ansi-escape-sequences-line-limit"] = 0
			vim.g["conjure#log#wrap"] = true
			vim.g["conjure#log#botright"] = true
		end,
	},
	{
		"tpope/vim-fireplace",
		enabled = false,
		ft = { "clojure", "edn" },
		keys = {
			{ "K", false }, 
			{ "<leader>er", "<cmd>Eval<CR>", mode = { "n", "v" }, desc = "Eval outer form / selection", }, 
			-- { "<leader>eb", "<cmd>
		},
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
	{
		"kovisoft/slimv",
		enabled = true,
		ft = { "lisp" },
		lazy = true,
		init = function()
			-- vim.g["slimv_swank_cmd"] = "! tmux new-window -d -n REPL-SBCL \"ros run -e '(ql:quickload :swank) (swank:create-server :dont-close t)'\""
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
