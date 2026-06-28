vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter"
})
require("vim._core.ui2").enable({}) -- experimental updated messages etc.

vim.cmd.colorscheme("theme")
vim.g.have_nerd_font = true
vim.g.mapleader = vim.keycode("<space>")
vim.g.maplocalleader = vim.keycode("<CR>")
vim.o.undofile = true
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.mouse = "a"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 0
vim.o.hlsearch = false
vim.o.splitright = true
vim.o.scrolloff = 10
vim.o.wrap = false
vim.o.complete = "o^5"
vim.o.completeopt = "menuone,noselect,popup,fuzzy"
vim.o.autocomplete = false -- prefer to hit i_CTRL-N to manually invoke
vim.o.pumheight = 10
vim.diagnostic.config({
    virtual_line = false,
    virtual_text = false,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
})

-- PICKERS
-- Find Files
function _G.RgFindFiles(cmdarg, _cmdcomplete)
    local fnames = vim.fn.systemlist("rg --files --hidden --color=never --glob=\"!.git\"")
    if #cmdarg == 0 then return fnames else return vim.fn.matchfuzzy(fnames, cmdarg) end
end
vim.o.findfunc = "v:lua.RgFindFiles" -- bind above function to the :find command
vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find files" })
-- Grep
vim.opt.grepprg = "rg --vimgrep --glob='!.git'" -- will need to put together an ignore list
vim.opt.grepformat = "%f:%l:%c:%m"
vim.keymap.set("n", "<leader>fg", ":silent grep! ", { desc = "Grep" })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking(copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- LSP
local required_servers = {
    "clojure_lsp",
    "cssls",
    "eslint",
    "html",
    "jsonls",
    "lua_ls",
    "marksman",
    "pylsp",
    "stylua",
    "vtsls",
    "vue_ls",
}
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({ ensure_installed = required_servers })
vim.lsp.enable(required_servers)

local kind_icons = {
    Text = "󰉿",
    Method = "󰊕",
    Function = "󰊕",
    Constructor = "󰒓",
    Field = "󰜢",
    Variable = "󰆦",
    Property = "󰖷",
    Class = "󱡠",
    Interface = "󱡠",
    Struct = "󱡠",
    Module = "󰅩",
    Unit = "󰪚",
    Value = "󰦨",
    Enum = "󰦨",
    EnumMember = "󰦨",
    Keyword = "󰻾",
    Constant = "󰏿",
    Snippet = "󱄽",
    Color = "󰏘",
    File = "󰈔",
    Reference = "󰬲",
    Folder = "󰉋",
    Event = "󱐋",
    Operator = "󰪚",
    TypeParameter = "󰬛",
}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
            convert = function(item)
                local kind = vim.lsp.protocol.CompletionItemKind[item.kind] or ""
                return {
                    -- insert the kind symbol ahead of the label, and then
                    -- override the kind and menu cols to be empty
                    abbr = (kind_icons[kind] or " ") .. " " .. (item.label:gsub("%b()", "")),
                    kind = "",
                    menu = "",
                }
            end,
        })
    end,
})

vim.api.nvim_create_autocmd("LspProgress", {
    callback = function(ev)
        local value = ev.data.params.value
        vim.api.nvim_echo({ { value.message or "done" } }, false, {
            id = "lsp." .. ev.data.params.token,
            kind = "progress",
            source = "vim.lsp",
            title = value.title,
            status = value.kind ~= "end" and "running" or "success",
            percent = value.percentage,
        })
    end,
})

-- FILE NAVIGATION
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "Buffer next", silent = true })
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "Buffer prev", silent = true })

-- UI
vim.keymap.set("n", "<leader>ud",
    function()
        local new_config = not vim.diagnostic.config().virtual_text
        vim.diagnostic.config({ virtual_text = new_config })
    end,
    { desc = "Toggle diagnostic virtual_text" }
)
vim.keymap.set("n", "<leader>un",
    function ()
        if vim.o.number then
            vim.o.signcolumn = "no"
            vim.o.number = false
            vim.o.relativenumber = false
        else
            vim.o.signcolumn = "yes"
            vim.o.number = true
            vim.o.relativenumber = true
        end
    end,
    { desc = "Toggle number", silent = true }
)

-- DIAGNOSTICS
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Open diagnosic under cursor" })

