-- Colorschemes
-- Theme collection with system appearance detection and cycling

return {
  -- High-contrast themes
  { "scottmckendry/cyberdream.nvim", lazy = false, priority = 1000 },
  { "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
  { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },

  -- Additional themes (lazy loaded)
  { "EdenEast/nightfox.nvim", lazy = true },
  { "olimorris/onedarkpro.nvim", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "folke/tokyonight.nvim", lazy = true },
  { "Mofiqul/dracula.nvim", lazy = true },

  -- Theme configuration
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
    config = function()
      -- Gruvbox Material: high contrast
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1

      -- Nightfly: deep navy theme
      vim.g.nightflyItalics = true
      vim.g.nightflyNormalFloat = true

      -- Tokyonight: moon variant
      require("tokyonight").setup({
        style = "moon",
        styles = { comments = { italic = false } },
      })

      -- Catppuccin: mocha flavor with integrations
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          treesitter = true,
          lsp_trouble = true,
          cmp = true,
          native_lsp = { enabled = true },
        },
      })

      -- OneDarkPro: vivid profile
      require("onedarkpro").setup({
        styles = {
          types = "bold",
          keywords = "bold",
          functions = "bold",
          comments = "italic",
        },
      })

      -- Cyberdream: neon cyberpunk
      require("cyberdream").setup({
        transparent = false,
        italic_comments = true,
        hide_fillchars = false,
        borderless_telescope = false,
        terminal_colors = true,
        theme = {
          variant = "default",
          saturation = 1,
          highlights = {
            Comment = { fg = "#7b8496", italic = true },
            ["@keyword"] = { fg = "#ff6e6e", bold = true },
            ["@function"] = { fg = "#5ef1ff", bold = true },
            ["@string"] = { fg = "#5eff6c" },
            ["@type"] = { fg = "#ffbd5e", bold = true },
          },
        },
      })

      -- Bold keywords/functions across all themes
      -- Rainbow delimiters colors (not included in most colorschemes)
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          local set = vim.api.nvim_set_hl
          set(0, "@keyword", { bold = true })
          set(0, "@function", { bold = true })
          set(0, "@type.builtin", { bold = true })
          set(0, "@constant.builtin", { bold = true })
          set(0, "@operator", { bold = true })
          set(0, "Statement", { bold = true })
          set(0, "Function", { bold = true })
          set(0, "Type", { bold = true })
          -- Rainbow delimiter colors
          set(0, "RainbowDelimiterRed", { fg = "#E06C75" })
          set(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
          set(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
          set(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
          set(0, "RainbowDelimiterGreen", { fg = "#98C379" })
          set(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
          set(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })
        end,
      })

      -- Theme cycling: <Space>ut to cycle through themes
      local themes = {
        "kanagawa-dragon",      -- dark, saturated (default dark)
        "catppuccin-latte",     -- light mode
        "cyberdream",           -- neon cyberpunk
        "carbonfox",            -- nightfox high-contrast
        "onedark_vivid",        -- vivid onedark
        "catppuccin-mocha",     -- saturated catppuccin
        "gruvbox-material",     -- with background=hard
        "tokyonight-moon",      -- brighter tokyonight
        "dracula",
        "nightfly",             -- deep midnight navy
      }
      local idx = 1

      local function set_theme(name)
        local ok, err = pcall(vim.cmd.colorscheme, name)
        if not ok then
          vim.notify("Failed to load colorscheme: " .. name .. "\n" .. tostring(err), vim.log.levels.WARN)
        else
          print("Theme: " .. name)
        end
      end

      vim.keymap.set("n", "<leader>ut", function()
        idx = (idx % #themes) + 1
        set_theme(themes[idx])
      end, { desc = "Cycle UI theme" })
    end,
  },
}
