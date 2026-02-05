return {
  -- LSP Configuration using native vim.lsp.config (Neovim 0.11+)
  {
    "hrsh7th/cmp-nvim-lsp",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      -- import cmp-nvim-lsp plugin
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local keymap = vim.keymap -- for conciseness

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings.
          local opts = { buffer = ev.buf, silent = true }

          -- set keybinds
          opts.desc = "Show LSP references"
          keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

          opts.desc = "Go to definition (declaration fallback)"
          keymap.set("n", "gD", vim.lsp.buf.definition, opts) -- go to definition (since gopls doesn't support declaration)

          opts.desc = "Show LSP definitions"
          keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

          opts.desc = "Show LSP implementations"
          keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

          opts.desc = "Show LSP type definitions"
          keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

          opts.desc = "See available code actions"
          keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

          opts.desc = "Smart rename"
          keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

          opts.desc = "Show buffer diagnostics"
          keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

          opts.desc = "Show line diagnostics"
          keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

          opts.desc = "Go to previous diagnostic"
          keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

          opts.desc = "Go to next diagnostic"
          keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

          opts.desc = "Show documentation for what is under cursor"
          keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

          opts.desc = "Restart LSP"
          keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end,
      })

      -- Change the Diagnostic symbols in the sign column (gutter)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Fix position encoding warning
      capabilities.offsetEncoding = { "utf-16" }

      -- Configure LSP servers using vim.lsp.config (Neovim 0.11+ native API)

      -- HTML
      vim.lsp.config.html = {
        capabilities = capabilities,
        settings = {
          html = {
            embeddedLanguages = {
              css = true,
              javascript = true,
            },
          },
        },
      }

      -- ts_ls disabled - using typescript-tools.nvim instead for better TS support

      -- Go
      vim.lsp.config.gopls = {
        capabilities = capabilities,
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      }

      -- Rust: handled by rustaceanvim plugin (see rust-tools.lua)

      -- Lua
      vim.lsp.config.lua_ls = {
        capabilities = capabilities,
        settings = {
          Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      }

      -- Python
      vim.lsp.config.pyright = {
        capabilities = capabilities,
      }

      -- JSON
      vim.lsp.config.jsonls = {
        capabilities = capabilities,
      }

      -- YAML
      vim.lsp.config.yamlls = {
        capabilities = capabilities,
      }

      -- Bash
      vim.lsp.config.bashls = {
        capabilities = capabilities,
      }

      -- Docker
      vim.lsp.config.dockerls = {
        capabilities = capabilities,
      }

      -- CSS
      vim.lsp.config.cssls = {
        capabilities = capabilities,
      }

      -- WGSL
      vim.lsp.config.wgsl_analyzer = {
        capabilities = capabilities,
      }

      -- TOML (taplo)
      vim.lsp.config.taplo = {
        capabilities = capabilities,
        settings = {
          evenBetterToml = {
            schema = {
              enabled = true,
              repositoryEnabled = true, -- Use schemas from schemastore (Cargo.toml, pyproject.toml, etc.)
            },
            formatter = {
              alignEntries = false,
              alignComments = true,
              arrayTrailingComma = true,
              columnWidth = 100,
              reorderKeys = true,
              trailingNewline = true,
            },
          },
        },
      }

      -- Enable all configured LSP servers
      -- Note: rust_analyzer is handled by rustaceanvim
      vim.lsp.enable("gopls")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("jsonls")
      vim.lsp.enable("yamlls")
      vim.lsp.enable("bashls")
      vim.lsp.enable("dockerls")
      vim.lsp.enable("html")
      vim.lsp.enable("cssls")
      vim.lsp.enable("wgsl_analyzer")
      vim.lsp.enable("taplo")
    end,
  },

  -- Mason for managing LSP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      -- import mason
      local mason = require("mason")

      local mason_tool_installer = require("mason-tool-installer")

      -- enable mason and configure icons
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_tool_installer.setup({
        ensure_installed = {
          -- LSP servers
          "gopls",           -- Go
          "rust-analyzer",   -- Rust
          "lua-language-server", -- Lua
          "pyright",         -- Python
          "json-lsp",        -- JSON
          "yaml-language-server", -- YAML
          "bash-language-server", -- Bash
          "dockerfile-language-server", -- Docker
          "html-lsp",        -- HTML
          "css-lsp",         -- CSS
          "taplo",           -- TOML
          -- ts_ls disabled - using typescript-tools.nvim instead

          -- Go tools
          "gofumpt",         -- Go formatter
          "goimports",       -- Go imports organizer
          "golines",         -- Go line length formatter
          "golangci-lint",   -- Go linter
          "delve",           -- Go debugger

          -- Rust tools (rustfmt comes from rustup, not Mason)
          "codelldb",        -- Rust/C++ debugger

          -- General tools
          "prettier",        -- Prettier formatter
          "stylua",          -- Lua formatter
          "isort",           -- Python import sorter
          "black",           -- Python formatter
          "pylint",          -- Python linter
          "eslint_d",        -- JS/TS linter
          "htmlhint",        -- HTML linter
          "shellcheck",      -- Shell script linter
          "shfmt",           -- Shell script formatter
        },
      })
    end,
  },
}
