return {
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvimdev/dashboard-nvim", enabled = false },
  {
    "nvim-web-devicons",
    opts = {
      strict = true,
      override_by_extension = {
        astro = {
          icon = "",
          color = "#EF8547",
          name = "astro",
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-web-devicons" },
    opts = { window = { position = "float" }, popup_border_style = "rounded" },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.window = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })
      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      opts.presets.lsp_doc_border = true
    end,
  },
}
