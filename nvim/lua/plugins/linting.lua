return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      html = { "htmlhint" },
      python = { "pylint" },
      go = { "golangcilint" },
      rust = { "clippy" },
    }

    -- Custom clippy linter configuration
    lint.linters.clippy = {
      cmd = "cargo",
      args = { "clippy", "--message-format=json", "-q" },
      stdin = false,
      append_fname = false,
      stream = "stdout",
      ignore_exitcode = true,
      parser = function(output, bufnr)
        local diagnostics = {}
        local fname = vim.api.nvim_buf_get_name(bufnr)
        for line in output:gmatch("[^\n]+") do
          local ok, decoded = pcall(vim.json.decode, line)
          if ok and decoded.reason == "compiler-message" then
            local msg = decoded.message
            if msg and msg.spans and #msg.spans > 0 then
              for _, span in ipairs(msg.spans) do
                if span.file_name and fname:match(span.file_name:gsub("%-", "%%-") .. "$") then
                  local severity = vim.diagnostic.severity.WARN
                  if msg.level == "error" then
                    severity = vim.diagnostic.severity.ERROR
                  elseif msg.level == "note" or msg.level == "help" then
                    severity = vim.diagnostic.severity.HINT
                  end
                  table.insert(diagnostics, {
                    lnum = span.line_start - 1,
                    end_lnum = span.line_end - 1,
                    col = span.column_start - 1,
                    end_col = span.column_end - 1,
                    severity = severity,
                    message = msg.message,
                    source = "clippy",
                  })
                end
              end
            end
          end
        end
        return diagnostics
      end,
    }

    -- Lint on save and when leaving insert mode
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- Manual lint with <leader>l
    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
