-- Zellij Integration
-- Seamless navigation between Neovim splits and Zellij panes.
-- Uses Ctrl+hjkl to navigate regardless of whether in Neovim or Zellij pane.

return {
  {
    "swaits/zellij-nav.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = {
      { "<c-h>", "<cmd>ZellijNavigateLeft<cr>", { silent = true, desc = "Navigate left" } },
      { "<c-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "Navigate down" } },
      { "<c-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "Navigate up" } },
      { "<c-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "Navigate right" } },
    },
    opts = {},
  },
}
