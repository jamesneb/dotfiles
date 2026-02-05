-- Terminal Integration
-- Floating and split terminal management

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      local Terminal = require("toggleterm.terminal").Terminal

      -- Go test runner
      local gotest = Terminal:new({
        cmd = "go test -v ./...",
        direction = "horizontal",
        close_on_exit = false,
      })

      -- Rust test runner
      local cargotest = Terminal:new({
        cmd = "cargo test",
        direction = "horizontal",
        close_on_exit = false,
      })

      function _gotest_toggle()
        gotest:toggle()
      end

      function _cargotest_toggle()
        cargotest:toggle()
      end

      -- Go tests: <leader>Gt to avoid conflict with git keymaps
      vim.api.nvim_set_keymap("n", "<leader>Gt", "<cmd>lua _gotest_toggle()<CR>", { noremap = true, silent = true, desc = "Run Go tests" })
      -- Rust tests: <leader>Rt to avoid conflict with rust-tools <leader>rt
      vim.api.nvim_set_keymap("n", "<leader>Rt", "<cmd>lua _cargotest_toggle()<CR>", { noremap = true, silent = true, desc = "Run Rust tests" })

      -- Terminal direction keymaps
      vim.api.nvim_set_keymap("n", "<leader>Tf", "<cmd>ToggleTerm direction=float<CR>", { noremap = true, silent = true, desc = "Float terminal" })
      vim.api.nvim_set_keymap("n", "<leader>Th", "<cmd>ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true, desc = "Horizontal terminal" })
      vim.api.nvim_set_keymap("n", "<leader>Tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", { noremap = true, silent = true, desc = "Vertical terminal" })
    end,
  },
}
