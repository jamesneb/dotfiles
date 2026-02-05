-- Which-Key
-- Displays available keybindings in a popup when you start pressing a key.
-- Helps discover and remember keybindings.

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    -- Wait for key sequences before showing which-key
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {},
}
