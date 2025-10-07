---@module 'snacks'
return {
    { -- works with treesitter to get the right comment style for an area with embedded languages eg. Vue SFC
        'JoosepAlviste/nvim-ts-context-commentstring'
    },
    { -- Detect tabstop and shiftwidth automatically
        "tpope/vim-sleuth",
        -- enabled = false,
        event = "VeryLazy",
    },
    { -- Better folding based on treesitter nodes
        "kevinhwang91/nvim-ufo",
        event = "VeryLazy",
        dependencies = "kevinhwang91/promise-async",
        opts = {
            ---@diagnostic disable-next-line: unused-local
            provider_selector = function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end,
        },
    },
    { -- Highlight todo, notes, etc in comments
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
        keys = {
            { "<leader>st", function() Snacks.picker.todo_comments() end,                                          desc = "Todo" },
            { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
        },
    },
    { -- Add indentation guides even on blank lines
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        main = "ibl",
        opts = {
            enabled = false,
            indent = { highlight = { "Whitespace" }, char = "▏" },
            scope = { enabled = false },
        },
        keys = {
            { "<leader>ui", "<cmd>IBLToggle<CR>", desc = "Toggle indent line" },
        }
    },
    { -- Helpful navigable file map to traverse the lsp tree
        "hedyhli/outline.nvim",
        keys = {
            { "<leader>o", "<cmd>Outline<CR>", desc = "Show [O]utline" }
        },
        opts = {},
    },
    {
    "rushjs1/nuxt-goto.nvim",
    ft = "vue",
    },
}
