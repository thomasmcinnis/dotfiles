return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    ---@class wk.Opts
    opts = {
        preset = "helix",
        spec = {
            { "<leader>a", group = "ai", mode = { "n", "v" } }
        },
        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 5,
            },
        },
        icons = { mappings = false },
        ---@type wk.Win.opts
        win = {
            border = "single",
        }
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)"
        },
    },
}

--[[ vim: set tabstop=4 shiftwidth=4 expandtab: --]]
