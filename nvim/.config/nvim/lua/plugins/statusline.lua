return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "meuter/lualine-so-fancy.nvim",
  },
  enabled = true,
  lazy = false,
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        -- theme = "catppuccin",
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {
            "help",
            "neo-tree",
            "Trouble",
            "spectre_panel",
            "toggleterm",
          },
          winbar = {},
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = {
          "fancy_branch",
          "fancy_diff",
          -- {
          --   "filename",
          --   path = 1, -- 2 for full path
          --   symbols = {
          --     modified = "  ",
          --     -- readonly = "  ",
          --     -- unnamed = "  ",
          --   },
          -- },
          { "fancy_searchcount" },
        },
        lualine_x = {
          { "fancy_diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
          "fancy_lsp_servers",
          "progress",
        },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        -- lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "neo-tree", "lazy" },
    })
  end,
}
-- return {
--   "nvim-lualine/lualine.nvim",
--   event = "VeryLazy",
--   opts = function()
--     return {
--       require("lualine").setup({
--         options = {
--           icons_enabled = true,
--           theme = "auto",
--           component_separators = { left = "", right = "" },
--           section_separators = { left = "", right = "" },
--           disabled_filetypes = {
--             statusline = {},
--             winbar = {},
--           },
--           ignore_focus = { "neo-tree" },
--           always_divide_middle = true,
--           globalstatus = true,
--           refresh = {
--             statusline = 1000,
--             tabline = 1000,
--             winbar = 1000,
--           },
--         },
--         sections = {
--           lualine_a = { "mode" },
--           lualine_b = { "branch", "diff", "diagnostics" },
--           lualine_c = { "filename" },
--           lualine_x = { " " },
--           lualine_y = { { "filetype", icon_only = true } },
--           lualine_z = { "location" },
--         },
--         inactive_sections = {
--           lualine_a = {},
--           lualine_b = {},
--           lualine_c = { "filename" },
--           lualine_x = { " " },
--           lualine_y = {},
--           lualine_z = {},
--         },
--         tabline = {},
--         winbar = {},
--         inactive_winbar = {},
--         extensions = {},
--       }),
--     }
--   end,
-- }
