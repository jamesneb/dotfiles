-- Block Stylua LSP
-- Prevents stylua from being started as an LSP server.
-- Stylua is a formatter, not a language server, but some plugins
-- incorrectly try to start it as one. This causes errors and warnings.
-- conform.nvim handles formatting; stylua LSP is unnecessary.

if vim.g.__block_stylua then
  return
end
vim.g.__block_stylua = true

-- Intercept vim.lsp.start to block stylua by name
if type(vim.lsp.start) == "function" then
  local orig_start = vim.lsp.start
  vim.lsp.start = function(cfg)
    if type(cfg) == "string" and cfg == "stylua" then
      return
    end
    if type(cfg) == "table" then
      local n = cfg.name
      local c = cfg.cmd
      if n == "stylua" or (type(c) == "table" and c[1] == "stylua") then
        return
      end
    end
    return orig_start(cfg)
  end
end

-- Intercept legacy start_client for older plugins
if type(vim.lsp.start_client) == "function" then
  local orig_start_client = vim.lsp.start_client
  vim.lsp.start_client = function(cfg)
    if type(cfg) == "table" then
      local n = cfg.name
      local c = cfg.cmd
      if n == "stylua" or (type(c) == "table" and c[1] == "stylua") then
        return nil
      end
    end
    return orig_start_client(cfg)
  end
end

-- Stop stylua client if it somehow attaches anyway
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local id = args.data and args.data.client_id or 0
    local client = id ~= 0 and vim.lsp.get_client_by_id(id) or nil
    if client and client.name == "stylua" then
      vim.schedule(function()
        pcall(vim.lsp.stop_client, client.id)
      end)
    end
  end,
})
