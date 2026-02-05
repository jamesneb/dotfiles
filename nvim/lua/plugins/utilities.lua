-- Utilities
-- Quality-of-life plugins: undo visualization, indent guides, notifications, live rename

return {
  -- Rainbow delimiters: color-matched brackets/parens
  -- Makes nested structures easier to parse visually
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = "rainbow-delimiters.strategy.global",
          vim = "rainbow-delimiters.strategy.local",
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- Undotree: visualize undo history as a tree
  -- Git for your buffer - see branches of edits and jump to any state
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
    },
    config = function()
      -- Open on the right side
      vim.g.undotree_WindowLayout = 3
      -- Shorter timestamps
      vim.g.undotree_ShortIndicators = 1
      -- Auto-focus undotree when opened
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },

  -- Indent guides: visual lines showing indent levels
  -- Helpful for Python, YAML, deeply nested code
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "trouble",
        },
      },
    },
  },

  -- Notifications: better UI for messages, LSP progress, etc.
  -- Replaces the cmdline message area with floating notifications
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      notify.setup({
        -- Animation style
        stages = "fade",
        -- Timeout in ms
        timeout = 3000,
        -- Max width of notification window
        max_width = 80,
        -- Minimum width
        min_width = 30,
        -- Icons
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "",
        },
        -- Render style: "default", "minimal", "simple"
        render = "default",
        -- Background color
        background_colour = "#000000",
      })
      -- Set as default notify handler
      vim.notify = notify
    end,
    keys = {
      {
        "<leader>nd",
        function() require("notify").dismiss({ silent = true, pending = true }) end,
        desc = "Dismiss notifications",
      },
    },
  },

  -- Live rename: see all occurrences update as you type
  -- Much better than blind LSP rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = function()
      require("inc_rename").setup({})
    end,
    keys = {
      {
        "<leader>rn",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename symbol (live preview)",
      },
    },
  },
}
