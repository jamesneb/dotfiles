-- Multi-Cursor and Text Manipulation
-- Multiple cursors, line movement, split/join, and enhanced increment/decrement

return {
  -- Multiple cursors (like VSCode Ctrl+D)
  {
    "mg979/vim-visual-multi",
    event = "BufEnter",
    init = function()
      -- Configuration must be set before plugin loads
      vim.g.VM_default_mappings = 1
      vim.g.VM_leader = "\\"
      vim.g.VM_theme = "iceblue"
      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",         -- Select word, repeat for next occurrence
        ["Find Subword Under"] = "<C-n>",
        ["Skip Region"] = "q",            -- Skip current match, get next
        ["Remove Region"] = "Q",          -- Remove this cursor
        ["Add Cursor Down"] = "<S-Down>", -- Add cursor below
        ["Add Cursor Up"] = "<S-Up>",     -- Add cursor above
      }
    end,
  },

  -- Move lines/selections with Alt+hjkl
  {
    "echasnovski/mini.move",
    version = "*",
    keys = {
      { "<M-h>", desc = "Move selection/line left" },
      { "<M-j>", desc = "Move selection/line down" },
      { "<M-k>", desc = "Move selection/line up" },
      { "<M-l>", desc = "Move selection/line right" },
    },
    config = function()
      require("mini.move").setup({
        mappings = {
          -- Visual mode
          left = "<M-h>",
          right = "<M-l>",
          down = "<M-j>",
          up = "<M-k>",
          -- Normal mode (current line)
          line_left = "<M-h>",
          line_right = "<M-l>",
          line_down = "<M-j>",
          line_up = "<M-k>",
        },
        options = {
          reindent_linewise = true,
        },
      })
    end,
  },

  -- Split/join arguments, arrays, etc. with gS
  {
    "echasnovski/mini.splitjoin",
    version = "*",
    keys = {
      { "gS", desc = "Toggle split/join" },
    },
    config = function()
      require("mini.splitjoin").setup({
        mappings = {
          toggle = "gS",
          split = "",
          join = "",
        },
      })
    end,
  },

  -- Enhanced increment/decrement with Ctrl+a/x
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", function() require("dial.map").inc_normal() end, desc = "Increment" },
      { "<C-x>", function() require("dial.map").dec_normal() end, desc = "Decrement" },
      { "<C-a>", function() require("dial.map").inc_visual() end, mode = "v", desc = "Increment" },
      { "<C-x>", function() require("dial.map").dec_visual() end, mode = "v", desc = "Decrement" },
      { "g<C-a>", function() require("dial.map").inc_gvisual() end, mode = "v", desc = "Increment sequence" },
      { "g<C-x>", function() require("dial.map").dec_gvisual() end, mode = "v", desc = "Decrement sequence" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          -- Numbers
          augend.integer.alias.decimal,
          augend.integer.alias.hex,

          -- Dates and times
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%m/%d/%Y"],
          augend.date.alias["%H:%M"],

          -- Boolean values
          augend.constant.alias.bool,
          augend.constant.new({ elements = { "True", "False" }, word = true, cyclic = true }),
          augend.constant.new({ elements = { "yes", "no" }, word = true, cyclic = true }),
          augend.constant.new({ elements = { "on", "off" }, word = true, cyclic = true }),

          -- Logical operators
          augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),

          -- Direction words
          augend.constant.new({ elements = { "left", "right" }, word = true, cyclic = true }),
          augend.constant.new({ elements = { "up", "down" }, word = true, cyclic = true }),
          augend.constant.new({ elements = { "top", "bottom" }, word = true, cyclic = true }),
          augend.constant.new({ elements = { "first", "last" }, word = true, cyclic = true }),

          -- Rust-specific
          augend.constant.new({ elements = { "Some", "None" }, word = true, cyclic = true }),
          augend.constant.new({ elements = { "Ok", "Err" }, word = true, cyclic = true }),
          augend.constant.new({ elements = { "pub", "" }, word = true, cyclic = true }),

          -- Visibility
          augend.constant.new({ elements = { "public", "private" }, word = true, cyclic = true }),
        },
      })
    end,
  },

  -- Text operators: duplicate, exchange, replace, sort
  {
    "echasnovski/mini.operators",
    version = "*",
    keys = {
      { "g=", desc = "Evaluate expression" },
      { "gx", desc = "Exchange regions" },
      { "gm", desc = "Multiply (duplicate) text" },
      { "gr", desc = "Replace with register" },
      { "gs", desc = "Sort text" },
    },
    config = function()
      require("mini.operators").setup({
        evaluate = { prefix = "g=" },
        exchange = { prefix = "gx", reindent_linewise = true },
        multiply = { prefix = "gm" },
        replace = { prefix = "gr", reindent_linewise = true },
        sort = { prefix = "gs" },
      })
    end,
  },
}
