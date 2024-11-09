-- [[ UI modifications ]]
-- Adjust built in lsp floating helper windows to be rounded and floating
local float = { focusable = true, style = "minimal", border = "rounded" }
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
	config = vim.tbl_extend("force", float, config or {})
	config.focus_id = ctx.method

	-- Only process if there's actual content
	if result and result.contents then
		local has_content = false

		if type(result.contents) == "string" then
			has_content = result.contents ~= ""
		elseif type(result.contents) == "table" then
			if result.contents[1] ~= nil then -- array-like table
				for _, content in ipairs(result.contents) do
					if type(content) == "string" and content ~= "" then
						has_content = true
						break
					elseif type(content) == "table" and content.value and content.value ~= "" then
						has_content = true
						break
					end
				end
			else -- non-array table
				has_content = not vim.tbl_isempty(result.contents)
			end
		end

		-- Only show the hover window if we have actual content
		if has_content then
			return vim.lsp.handlers.hover(_, result, ctx, config)
		end
	end

	-- Return nil without showing any notification for empty results
	return nil
end
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
-- Set the title string to support pane identification in Windows
vim.opt.title = true
vim.opt.titlestring = "nvim"

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

-- Show the signcolumn
vim.opt.signcolumn = "yes"

-- Enable folding
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Show line numbers and relative numbers
vim.wo.relativenumber = true
vim.wo.number = true

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

-- Show LSP loading indicator
vim.api.nvim_create_autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(vim.lsp.status(), "info", {
			id = "lsp_progress",
			title = "LSP Progress",
			opts = function(notif)
				notif.icon = ev.data.params.value.kind == "end" and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
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
