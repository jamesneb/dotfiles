-- Project Navigation
-- File and project management tools

return {
  -- Project detection and switching
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "go.mod", "Cargo.toml" },
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = "global",
      })
      require("telescope").load_extension("projects")
    end,
  },

  -- Oil: edit filesystem like a buffer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    config = function()
      -- Auto-drill into single nested directories (up to 3 levels)
      local function drill_down(depth)
        depth = depth or 0
        if depth >= 3 then return end

        local oil = require("oil")
        local entry = oil.get_cursor_entry()

        if entry and entry.type == "directory" then
          oil.select({}, function()
            vim.schedule(function()
              local dir = oil.get_current_dir()
              if not dir then return end

              local entries = {}
              local handle = vim.loop.fs_scandir(dir)
              if handle then
                while true do
                  local name, type = vim.loop.fs_scandir_next(handle)
                  if not name then break end
                  table.insert(entries, { name = name, type = type })
                end
              end

              -- If single directory entry, keep drilling
              if #entries == 1 and entries[1].type == "directory" then
                vim.cmd("normal! gg")
                drill_down(depth + 1)
              end
            end)
          end)
        end
      end

      require("oil").setup({
        view_options = { show_hidden = true },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-s>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["<BS>"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["<C-l>"] = {
            callback = function() drill_down() end,
            desc = "Drill into nested directories",
          },
        },
      })
    end,
  },

  -- Harpoon: quick file navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add to harpoon" })
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
      vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
      vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
      vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
      vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
      vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Previous harpoon" })
      vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Next harpoon" })
    end,
  },
}
