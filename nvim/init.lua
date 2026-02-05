-- Neovim Configuration Entry Point
-- Bootstraps lazy.nvim and loads all configuration modules

-- Bootstrap lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set leader keys before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load core configuration modules
-- These must load before plugins to set basic options
pcall(require, "config.options")
pcall(require, "config.keymaps")
pcall(require, "config.autocmds")

-- Initialize lazy.nvim with all plugins from lua/plugins/
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- Use SSH for git operations
  git = { url_format = "git@github.com:%s.git" },
  -- Default colorscheme during plugin installation
  install = { colorscheme = { "tokyonight" } },
  -- Check for plugin updates
  checker = { enabled = true },
})

-- Ensure syntax highlighting and filetype detection are enabled
vim.cmd([[
  if exists('g:syntax_on') == 0 | syntax enable | endif
  filetype plugin indent on
]])
