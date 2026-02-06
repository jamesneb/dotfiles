-- Autocommands
-- Automatic behaviors triggered by events

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General autocommands group
local general = augroup("General", { clear = true })

-- Highlight yanked text briefly
autocmd("TextYankPost", {
  group = general,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- Disable auto-commenting on new lines
autocmd("BufEnter", {
  group = general,
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- JSON: disable concealing (show quotes)
local filetype_settings = augroup("FiletypeSettings", { clear = true })
autocmd("FileType", {
  group = filetype_settings,
  pattern = { "json", "jsonc" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Filetype-specific colorschemes with system appearance detection
local filetype_themes = augroup("FiletypeThemes", { clear = true })

-- Detect macOS light/dark mode
local function is_light_mode()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    return result == ""  -- empty = light mode, "Dark" = dark mode
  end
  return false
end

-- Default theme based on system appearance
local function get_default_theme()
  return is_light_mode() and "catppuccin-latte" or "kanagawa-dragon"
end

-- Override theme for specific filetypes
local theme_by_filetype = {
  rust = "kanagawa-dragon",
  typescript = "cyberdream",
  typescriptreact = "cyberdream",
}

-- Rainbow delimiter highlight colors (not defined by most colorschemes)
local function set_rainbow_colors()
  local set = vim.api.nvim_set_hl
  set(0, "RainbowDelimiterRed", { fg = "#E06C75" })
  set(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
  set(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
  set(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
  set(0, "RainbowDelimiterGreen", { fg = "#98C379" })
  set(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
  set(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })
end

-- Filetypes to ignore (plugin UI buffers)
local ignore_filetypes = {
  ["neo-tree"] = true,
  ["NvimTree"] = true,
  ["TelescopePrompt"] = true,
  ["TelescopeResults"] = true,
  ["lazy"] = true,
  ["mason"] = true,
  ["notify"] = true,
  ["noice"] = true,
  ["qf"] = true,
  ["help"] = true,
  ["toggleterm"] = true,
  [""] = true,
}

-- Set default theme on startup
autocmd("VimEnter", {
  group = filetype_themes,
  pattern = "*",
  callback = function()
    pcall(vim.cmd.colorscheme, get_default_theme())
    set_rainbow_colors()
  end,
})

-- Switch theme based on filetype
autocmd("BufEnter", {
  group = filetype_themes,
  pattern = "*",
  callback = function()
    local ft = vim.bo.filetype
    if ignore_filetypes[ft] then return end
    local theme = theme_by_filetype[ft] or get_default_theme()
    if theme and vim.g.colors_name ~= theme then
      pcall(vim.cmd.colorscheme, theme)
      set_rainbow_colors()
    end
  end,
})

-- Auto-resize splits when terminal window resizes
autocmd("VimResized", {
  group = general,
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Restore cursor position when opening a file
autocmd("BufReadPost", {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Show cursor line only in active window
local cursor_line = augroup("CursorLine", { clear = true })

autocmd({ "InsertLeave", "WinEnter" }, {
  group = cursor_line,
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})

autocmd({ "InsertEnter", "WinLeave" }, {
  group = cursor_line,
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})
