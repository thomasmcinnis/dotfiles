return {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
        -- require('mini.ai').setup({ n_lines = 500 })
        require('mini.diff').setup({
            view = { style = "sign" },
            config = function()
                local diff = require("mini.diff")
                diff.setup({
                    -- Disabled by default
                    source = diff.gen_source.none(),
                })
            end,
        })
        require('mini.surround').setup()
        -- require('mini.pairs').setup()
        require('mini.comment').setup()
        require('mini.bracketed').setup()
        require('mini.icons').setup()
    end,
}
