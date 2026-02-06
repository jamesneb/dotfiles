-- Utilities
-- Quality-of-life plugins: undo visualization, indent guides, notifications, live rename

return {
  -- Rainbow delimiters: color-matched brackets/parens
  -- Makes nested structures easier to parse visually
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = false,
    init = function()
      -- Must be set BEFORE plugin loads
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
    config = function()
      -- Define highlight colors (some colorschemes don't include these)
      local function set_rainbow_colors()
        vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })
      end
      -- Apply after colorscheme loads
      vim.api.nvim_create_autocmd("ColorScheme", { callback = set_rainbow_colors })
      -- Also apply on VimEnter (after everything loads)
      vim.api.nvim_create_autocmd("VimEnter", { callback = set_rainbow_colors })
      -- And apply now in case colorscheme already loaded
      set_rainbow_colors()
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
