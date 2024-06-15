---@diagnostic disable: missing-fields
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "astro-language-server",
        "tailwindcss-language-server",
        "css-lsp",
        "prettier",
      })
      opts.ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        ---@type lspconfig.options
        html = {},
        cssls = {},
      },
    },
  },
}
