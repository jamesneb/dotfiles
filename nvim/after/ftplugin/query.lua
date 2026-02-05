-- after/ftplugin/query.lua
-- Some plugins use a nonstandard "query" ft for SQL. Force it to "sql".
vim.schedule(function()
  if vim.bo.filetype == "query" then
    vim.cmd("setfiletype sql")
  end
end)

