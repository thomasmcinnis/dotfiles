-- [[ UI modifications ]]
-- Globals
vim.g.have_nerd_font = true

-- Custom hover for signature, hover, diagnostics
---@type vim.diagnostic.Opts.Float
local float = { focusable = false, style = "minimal", border = "none", source = true }
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)
vim.diagnostic.config({ virtual_text = true, severity_sort = true, float })

-- LSP Progress indicator
local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
vim.api.nvim_create_autocmd("LspProgress", {
	desc = "Show visual spinner for lsp loading the workspace",
	callback = function(ev)
		local spinner_idx = math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner_frames + 1
		vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
			id = "lsp_progress",
			title = "LSP Progress",
			opts = function(notif)
				notif.icon = ev.data.params.value.kind == "end" and " " or spinner_frames[spinner_idx]
			end,
		})
	end,
})

-- Highligt text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Open help docs in a vertical split to the right with a width of 80 columns
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L | vertical resize 80",
})

-- [[ Basic settings ]]
-- Editor options
local options = {
	number = true,
	relativenumber = true,
	signcolumn = "yes:1",
	mouse = "a",
	wrap = false,
	ignorecase = true,
	smartcase = true,
	hlsearch = true,
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	scrolloff = 10,
	cursorline = false,
	inccommand = "split",
	laststatus = 3,
	foldlevel = 99,
	foldlevelstart = 99,
	foldenable = true,
}

for k, v in pairs(options) do
	vim.o[k] = v
end

-- [[ Clipboard configuration ]]
--
-- Make capital Y and P for using system clipboard
vim.keymap.set({ "n", "v" }, "Y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "P", '"+p', { desc = "Put from system clipboard" })

-- WSL specific
if vim.fn.has("wsl") == 1 then
	local clip_ex_path = vim.fn.executable("clip.exe")
	if clip_ex_path == 1 then
		vim.g.clipboard = {
			name = "win_clipboard",
			copy = {
				["+"] = "clip.exe",
				["*"] = "clip.exe",
			},
			paste = {
				["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
				["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			},
			cache_enabled = 0,
		}
	else
		vim.notify("clip.exe not found in $PATH. No system clipboard saving possible", vim.log.levels.ERROR)
	end
end
