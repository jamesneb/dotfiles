-- after/ftplugin/sql.lua

-- Hard-stop Treesitter in this buffer (even if some plugin tries to attach it)
pcall(vim.treesitter.stop, 0)
vim.api.nvim_create_autocmd("BufEnter", {
  buffer = 0,
  callback = function() pcall(vim.treesitter.stop, 0) end,
})

-- Make sure classic Vim syntax is on and (re)source SQL syntax
vim.cmd([[
  syntax enable
  runtime! syntax/sql.vim
  runtime! after/syntax/sql.vim
]])

