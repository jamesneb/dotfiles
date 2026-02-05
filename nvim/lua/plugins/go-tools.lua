-- Go Development Tools
-- Provides Go-specific IDE features: struct tags, test generation, debugging

return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",            -- floating window UI
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        -- Formatting: use gopls with gofumpt style
        goimports = "gopls",
        gofmt = "gofumpt",
        max_line_len = 120,

        -- Struct tags: add json=omitempty by default
        tag_transform = false,
        tag_options = "json=omitempty",

        -- Icons for debugger
        icons = { breakpoint = "B", currentpos = ">" },

        -- LSP: let lsp.lua handle gopls config, just enable formatting
        lsp_cfg = false,
        lsp_gofumpt = true,
        lsp_keymaps = true,
        lsp_codelens = true,
        lsp_diag_underline = true,
        lsp_diag_virtual_text = { space = 0, prefix = "" },
        lsp_diag_signs = true,
        lsp_diag_update_in_insert = false,
        lsp_document_formatting = true,

        -- Inlay hints
        lsp_inlay_hints = {
          enable = true,
          only_current_line = false,
          only_current_line_autocmd = "CursorHold",
          show_variable_name = true,
          parameter_hints_prefix = " ",
          show_parameter_hints = true,
          other_hints_prefix = "=> ",
          max_len_align = false,
          right_align = false,
          highlight = "Comment",
        },

        -- Debugging via delve
        dap_debug = true,
        dap_debug_keymap = true,
        dap_debug_gui = {},
        dap_debug_vt = { enabled_commands = true, all_frames = true },

        -- Text objects via treesitter
        textobjects = true,

        -- Test runner
        test_runner = "go",
        verbose_tests = true,
        run_in_floaterm = false,

        -- Use trouble.nvim for quickfix
        trouble = false,
        luasnip = false,
        iferr_vertical_shift = 4,
      })

      local keymap = vim.keymap

      -- Struct tag operations
      keymap.set("n", "<leader>gsj", "<cmd>GoAddTag json<cr>", { desc = "Add json struct tags" })
      keymap.set("n", "<leader>gsy", "<cmd>GoAddTag yaml<cr>", { desc = "Add yaml struct tags" })
      keymap.set("n", "<leader>gst", "<cmd>GoAddTag<cr>", { desc = "Add struct tags (prompt)" })
      keymap.set("n", "<leader>gsr", "<cmd>GoRmTag<cr>", { desc = "Remove struct tags" })

      -- Test generation and execution
      keymap.set("n", "<leader>gta", "<cmd>GoAddTest<cr>", { desc = "Add test for current function" })
      keymap.set("n", "<leader>gts", "<cmd>GoAddExpTest<cr>", { desc = "Add tests for exported functions" })
      keymap.set("n", "<leader>gtf", "<cmd>GoTestFunc<cr>", { desc = "Run test for current function" })
      keymap.set("n", "<leader>gtc", "<cmd>GoCoverage<cr>", { desc = "Show test coverage" })

      -- Code generation
      keymap.set("n", "<leader>gff", "<cmd>GoFillStruct<cr>", { desc = "Fill struct fields" })
      keymap.set("n", "<leader>gfw", "<cmd>GoFillSwitch<cr>", { desc = "Fill switch cases" })
      keymap.set("n", "<leader>gif", "<cmd>GoIfErr<cr>", { desc = "Add if err != nil block" })
      keymap.set("n", "<leader>gie", "<cmd>GoImpl<cr>", { desc = "Generate interface implementation" })

      -- Build and run
      keymap.set("n", "<leader>gr", "<cmd>GoRun<cr>", { desc = "Go run" })
      keymap.set("n", "<leader>gB", "<cmd>GoBuild<cr>", { desc = "Go build" })
    end,
  },
}
