return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>mp",
      function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end,
      mode = { "n", "v" },
      desc = "Format file or range",
    },
  },
  config = function()
    local conform = require("conform")

    conform.setup({
      log_level = vim.log.levels.DEBUG,
      notify_on_error = true,
      formatters = {
        rustfmt = {
          command = "rustfmt",
          args = { "+nightly", "--edition", "2024", "--emit", "stdout" },
          stdin = true,
        },
      },
      formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      liquid = { "prettier" },
      lua = { "stylua" },
      python = { "isort", "black" },
      go = { "goimports", "gofumpt" },
      rust = { "rustfmt" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
    },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })
  end,
}