-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local float = { focusable = true, style = "minimal", border = "rounded" }

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)

vim.filetype.add({
  extension = {
    mdx = "mdx",
    astro = "astro",
  },
})

local config = {
  virtual_text = true,
  update_in_insert = false,
  underline = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}
vim.diagnostic.config(config)

local opt = vim.opt
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
opt.exrc = true -- Enable project based config files
opt.pumblend = 0 -- Popup blend opacity
opt.scrolloff = 10 -- Increase top and bottom scrolloff to 10
opt.sidescrolloff = 0 -- Remove aggressive side scrolloff
opt.colorcolumn = "80" -- Add columnline
opt.backspace = { "start", "eol", "indent" } -- don't have to delete white space
