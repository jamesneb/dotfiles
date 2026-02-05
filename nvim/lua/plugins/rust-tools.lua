return {
  -- Modern Rust development (replaces deprecated rust-tools.nvim)
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false, -- Plugin is already lazy
    ft = { "rust" },
    init = function()
      -- Configure rustaceanvim via vim.g.rustaceanvim
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          -- How to execute terminal commands
          executor = "termopen",

          -- Automatically call RustReloadWorkspace when writing to a Cargo.toml file
          reload_workspace_from_cargo_toml = true,

          -- Options for hover actions
          hover_actions = {
            border = {
              { "╭", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╮", "FloatBorder" },
              { "│", "FloatBorder" },
              { "╯", "FloatBorder" },
              { "─", "FloatBorder" },
              { "╰", "FloatBorder" },
              { "│", "FloatBorder" },
            },
            auto_focus = false,
          },
        },

        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            local keymap = vim.keymap
            local opts = { buffer = bufnr, silent = true }

            -- Rust-specific keymaps
            opts.desc = "Hover actions"
            keymap.set("n", "<C-space>", function()
              vim.cmd.RustLsp({ "hover", "actions" })
            end, opts)

            opts.desc = "Code action group"
            keymap.set("n", "<Leader>a", function()
              vim.cmd.RustLsp("codeAction")
            end, opts)
          end,

          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              checkOnSave = true,
              check = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
              inlayHints = {
                bindingModeHints = { enable = false },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 25 },
                closureReturnTypeHints = { enable = "never" },
                lifetimeElisionHints = { enable = "never", useParameterNames = false },
                maxLength = 25,
                parameterHints = { enable = true },
                reborrowHints = { enable = "never" },
                renderColons = true,
                typeHints = {
                  enable = true,
                  hideClosureInitialization = false,
                  hideNamedConstructor = false,
                },
              },
            },
          },
        },

        -- DAP configuration
        dap = {},
      }
    end,
    config = function()
      -- Key mappings for Rust tools
      local keymap = vim.keymap

      -- Rust-specific commands (using RustLsp command)
      keymap.set("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end, { desc = "Rust runnables" })
      keymap.set("n", "<leader>rt", function() vim.cmd.RustLsp("testables") end, { desc = "Rust testables" })
      keymap.set("n", "<leader>rm", function() vim.cmd.RustLsp("expandMacro") end, { desc = "Rust expand macro" })
      keymap.set("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end, { desc = "Open Cargo.toml" })
      keymap.set("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end, { desc = "Rust parent module" })
      keymap.set("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end, { desc = "Rust debuggables" })
      keymap.set("n", "<leader>rh", function() vim.cmd.RustLsp({ "hover", "actions" }) end, { desc = "Hover actions" })
      keymap.set("n", "<leader>rj", function() vim.cmd.RustLsp("joinLines") end, { desc = "Join lines" })
      keymap.set("n", "<leader>ra", function() vim.cmd.RustLsp("codeAction") end, { desc = "Code action" })
      keymap.set("n", "<leader>re", function() vim.cmd.RustLsp("explainError") end, { desc = "Explain error" })
      keymap.set("n", "<leader>rw", function() vim.cmd.RustLsp("reloadWorkspace") end, { desc = "Reload workspace" })
      keymap.set("n", "<leader>rs", function() vim.cmd.RustLsp("ssr") end, { desc = "Structural search replace" })
      keymap.set("n", "<leader>rg", function() vim.cmd.RustLsp("crateGraph") end, { desc = "View crate graph" })
    end,
  },

  -- Cargo.toml dependency management
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        smart_insert = true,
        insert_closing_quote = true,
        autoload = true,
        autoupdate = true,
        loading_indicator = true,
        date_format = "%Y-%m-%d",
        thousands_separator = ",",
        notification_title = "crates.nvim",
        curl_args = { "-sL", "--retry", "1" },
        max_parallel_requests = 80,

        text = {
          loading = "   Loading",
          version = "   %s",
          prerelease = "   %s",
          yanked = "   %s, yanked",
          nomatch = "   No match",
          upgrade = "   %s",
          error = "   Error fetching crate",
        },

        highlight = {
          loading = "CratesNvimLoading",
          version = "CratesNvimVersion",
          prerelease = "CratesNvimPreRelease",
          yanked = "CratesNvimYanked",
          nomatch = "CratesNvimNoMatch",
          upgrade = "CratesNvimUpgrade",
          error = "CratesNvimError",
        },

        popup = {
          autofocus = false,
          hide_on_select = false,
          copy_register = '"',
          style = "minimal",
          border = "none",
          show_version_date = false,
          show_dependency_version = true,
          max_height = 30,
          min_width = 20,
          padding = 1,
        },

        completion = {
          insert_closing_quote = true,
          text = {
            prerelease = "  pre-release ",
            yanked = "  yanked ",
          },
        },
      })

      -- Key mappings for crates.nvim
      local keymap = vim.keymap

      keymap.set("n", "<leader>ct", require("crates").toggle, { desc = "Toggle crates.nvim" })
      keymap.set("n", "<leader>cr", require("crates").reload, { desc = "Reload crates" })

      keymap.set("n", "<leader>cv", require("crates").show_versions_popup, { desc = "Show versions popup" })
      keymap.set("n", "<leader>cf", require("crates").show_features_popup, { desc = "Show features popup" })
      keymap.set("n", "<leader>cd", require("crates").show_dependencies_popup, { desc = "Show dependencies popup" })

      keymap.set("n", "<leader>cu", require("crates").update_crate, { desc = "Update crate" })
      keymap.set("v", "<leader>cu", require("crates").update_crates, { desc = "Update crates" })
      keymap.set("n", "<leader>ca", require("crates").update_all_crates, { desc = "Update all crates" })
      keymap.set("n", "<leader>cU", require("crates").upgrade_crate, { desc = "Upgrade crate" })
      keymap.set("v", "<leader>cU", require("crates").upgrade_crates, { desc = "Upgrade crates" })
      keymap.set("n", "<leader>cA", require("crates").upgrade_all_crates, { desc = "Upgrade all crates" })

      keymap.set("n", "<leader>ce", require("crates").expand_plain_crate_to_inline_table, { desc = "Expand to inline table" })
      keymap.set("n", "<leader>cE", require("crates").extract_crate_into_table, { desc = "Extract into table" })

      keymap.set("n", "<leader>cH", require("crates").open_homepage, { desc = "Open homepage" })
      keymap.set("n", "<leader>cR", require("crates").open_repository, { desc = "Open repository" })
      keymap.set("n", "<leader>cD", require("crates").open_documentation, { desc = "Open documentation" })
      keymap.set("n", "<leader>cC", require("crates").open_crates_io, { desc = "Open crates.io" })
    end,
  },
}
