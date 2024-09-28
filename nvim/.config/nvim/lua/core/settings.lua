-- [[ UI modifications ]]
-- Adjust built in lsp floating helper windows to be rounded and floating
local float = { focusable = true, style = "minimal", border = "rounded" }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

-- Adjust error diagnostics to be floating
vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	float = {
		source = "if_many",
		style = "minimal",
		border = "rounded",
	},
})

-- Make status column: FOLD_RELNUM_SIGN
vim.opt.statuscolumn =
	[[%{(foldlevel(v:lnum) && foldlevel(v:lnum) > foldlevel(v:lnum - 1)) ? (foldclosed(v:lnum) == -1 ? '⌄' : '›') : ' '} %=%{v:relnum ? v:relnum : v:lnum .. ' '} %s]]
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Filetype support ]]
vim.filetype.add({
	extension = {
		mdx = "mdx",
		astro = "astro",
	},
})

-- [[ Setting options ]]
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Enable smooth scroll available since nvim 0.10
vim.opt.smoothscroll = true

-- Make backspace behave like every other editor.
vim.opt.backspace = "indent,eol,start"

-- Set tab width to 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Don't show the command line
vim.opt.cmdheight = 0

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Hide statuscolumn for certain filetypes eg neotree and outline
vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Hide statuscolumn for neotree and outline",
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "neo-tree" or vim.bo.filetype == "Outline" then
			vim.opt_local.statuscolumn = ""
		end
	end,
})
