-- Debugging and Testing
-- DAP (Debug Adapter Protocol) configuration for Go and Rust

return {
  -- DAP core
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",           -- UI for debugging
      "theHamsta/nvim-dap-virtual-text", -- inline variable values
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("dapui").setup()
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        display_callback = function(variable, buf, stackframe, node, options)
          if options.virt_text_pos == "inline" then
            return " = " .. variable.value
          else
            return variable.name .. " = " .. variable.value
          end
        end,
        virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })

      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Go: delve debugger
      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
      }

      -- Rust: codelldb debugger
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.rust = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      -- Debugging keymaps
      vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<Leader>db", dap.step_back, { desc = "Step back" })
      vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue" })
      vim.keymap.set("n", "<Leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
      vim.keymap.set("n", "<Leader>dd", dap.disconnect, { desc = "Disconnect" })
      vim.keymap.set("n", "<Leader>dg", dap.session, { desc = "Get session" })
      vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step into" })
      vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<Leader>dO", dap.step_out, { desc = "Step out" })
      vim.keymap.set("n", "<Leader>dp", dap.pause, { desc = "Pause" })
      vim.keymap.set("n", "<Leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
      vim.keymap.set("n", "<Leader>ds", dap.continue, { desc = "Start" })
      vim.keymap.set("n", "<Leader>dq", dap.terminate, { desc = "Terminate" })
      vim.keymap.set("n", "<Leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
    end,
  },

  -- Go-specific debugging
  {
    "leoluz/nvim-dap-go",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("dap-go").setup()
    end,
  },

  -- Neotest: testing framework
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-go"),
          require("neotest-rust")({
            args = { "--no-capture" },
            dap_adapter = "codelldb",
          }),
        },
      })

      -- Testing keymaps
      vim.keymap.set("n", "<leader>tt", function()
        require("neotest").run.run()
      end, { desc = "Run nearest test" })

      vim.keymap.set("n", "<leader>tf", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, { desc = "Run current file tests" })

      vim.keymap.set("n", "<leader>td", function()
        require("neotest").run.run({ strategy = "dap" })
      end, { desc = "Debug nearest test" })

      vim.keymap.set("n", "<leader>ts", function()
        require("neotest").summary.toggle()
      end, { desc = "Toggle test summary" })

      vim.keymap.set("n", "<leader>to", function()
        require("neotest").output.open({ enter = true })
      end, { desc = "Open test output" })
    end,
  },
}
