-- ftdetect/sql.lua
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.sql", "*.ddl", "*.clickhouse.sql", "*.ch.sql" },
  callback = function(args)
    vim.bo[args.buf].filetype = "sql"
  end,
})

