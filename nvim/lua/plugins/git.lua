-- Git Integration
-- Version control tools and UI

return {
  -- Gitsigns: git status in sign column, hunk navigation
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation between hunks
        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Previous hunk")

        -- Stage/reset hunks
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage hunk")
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset hunk")

        -- Buffer operations
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")

        -- Preview and blame
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")

        -- Diff
        map("n", "<leader>hd", gs.diffthis, "Diff this")
        map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff this ~")

        -- Text object for hunks
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
      end,
    },
  },

  -- Lazygit: terminal UI for git
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- Git blame: inline blame information
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = false,  -- start disabled, toggle with keymap
      message_template = " <summary> | <date> | <author> | <<sha>>",
      date_format = "%Y-%m-%d %H:%M",
      virtual_text_column = 1,
    },
    keys = {
      { "<leader>gbt", "<cmd>GitBlameToggle<cr>", desc = "Toggle git blame" },
      { "<leader>gbo", "<cmd>GitBlameOpenCommitURL<cr>", desc = "Open commit URL" },
      { "<leader>gbc", "<cmd>GitBlameCopySHA<cr>", desc = "Copy SHA" },
    },
  },

  -- Neogit: magit-style git interface
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
    keys = {
      { "<leader>gs", "<cmd>Neogit<cr>", desc = "Neogit status" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit commit" },
      { "<leader>gp", "<cmd>Neogit pull<cr>", desc = "Neogit pull" },
      { "<leader>gP", "<cmd>Neogit push<cr>", desc = "Neogit push" },
    },
  },

  -- Diffview: side-by-side diff viewer
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {},
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
      { "<leader>gx", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
    },
  },

  -- Git conflict: resolve merge conflicts
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = "copen",
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
      })

      -- Conflict resolution keymaps
      vim.keymap.set("n", "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", { desc = "Choose ours" })
      vim.keymap.set("n", "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Choose theirs" })
      vim.keymap.set("n", "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Choose both" })
      vim.keymap.set("n", "<leader>gc0", "<cmd>GitConflictChooseNone<cr>", { desc = "Choose none" })
      vim.keymap.set("n", "]x", "<cmd>GitConflictNextConflict<cr>", { desc = "Next conflict" })
      vim.keymap.set("n", "[x", "<cmd>GitConflictPrevConflict<cr>", { desc = "Previous conflict" })
    end,
  },
}
