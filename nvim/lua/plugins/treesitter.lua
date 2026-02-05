return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      config = function()
        -- Setup textobjects config
        require("nvim-treesitter-textobjects").setup({
          select = { lookahead = true },
          move = { set_jumps = true },
        })

        local select = require("nvim-treesitter-textobjects.select")
        local move = require("nvim-treesitter-textobjects.move")

        -- Selection keymaps (visual and operator-pending modes)
        local select_maps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        }
        for key, query in pairs(select_maps) do
          vim.keymap.set({ "x", "o" }, key, function()
            select.select_textobject(query)
          end, { desc = "Select " .. query })
        end

        -- Movement keymaps
        vim.keymap.set({ "n", "x", "o" }, "]f", function()
          move.goto_next_start("@function.outer")
        end, { desc = "Next function start" })
        vim.keymap.set({ "n", "x", "o" }, "[f", function()
          move.goto_previous_start("@function.outer")
        end, { desc = "Previous function start" })
        vim.keymap.set({ "n", "x", "o" }, "]c", function()
          move.goto_next_start("@class.outer")
        end, { desc = "Next class start" })
        vim.keymap.set({ "n", "x", "o" }, "[c", function()
          move.goto_previous_start("@class.outer")
        end, { desc = "Previous class start" })
      end,
    },
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        "python",
        "rust",
        "go",
        "java",
        "php",
        "ruby",
        "sql",
        "toml",
        "xml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}