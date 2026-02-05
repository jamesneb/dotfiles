vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

-- Cargo rename crate
vim.keymap.set("n", "<leader>rR", function()
  vim.ui.input({ prompt = "Old crate name: " }, function(old_name)
    if not old_name or old_name == "" then return end
    vim.ui.input({ prompt = "New crate name: " }, function(new_name)
      if not new_name or new_name == "" then return end
      -- Find workspace root (directory with Cargo.toml containing [workspace])
      local root = vim.fs.root(0, { "Cargo.lock" }) or vim.fn.getcwd()
      vim.cmd("!" .. "cd " .. root .. " && cargo rename --both -y --allow-dirty " .. old_name .. " " .. new_name)
    end)
  end)
end, { buffer = true, desc = "Cargo rename crate" })
