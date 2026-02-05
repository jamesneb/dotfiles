-- ~/.config/nvim/lua/plugins/database.lua
-- vim-dadbod for database management (DataGrip alternative)
return {
  -- Core dadbod
  {
    "tpope/vim-dadbod",
    cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection" },
  },

  -- UI for dadbod (drawer with connections, saved queries)
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle Database UI" },
      { "<leader>dB", "<cmd>DBUIAddConnection<cr>", desc = "Add DB Connection" },
      { "<leader>df", "<cmd>DBUIFindBuffer<cr>", desc = "Find DB Buffer" },
    },
    init = function()
      -- Store connections/queries in nvim config dir
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_force_echo_notifications = true

      -- Table helpers for quick queries
      vim.g.db_ui_table_helpers = {
        postgresql = {
          Count = "SELECT COUNT(*) FROM {table}",
          Columns = "SELECT column_name, data_type FROM information_schema.columns WHERE table_name = '{table}'",
          Sample = "SELECT * FROM {table} LIMIT 100",
        },
        mysql = {
          Count = "SELECT COUNT(*) FROM {table}",
          Columns = "DESCRIBE {table}",
          Sample = "SELECT * FROM {table} LIMIT 100",
        },
        sqlite = {
          Count = "SELECT COUNT(*) FROM {table}",
          Schema = ".schema {table}",
          Sample = "SELECT * FROM {table} LIMIT 100",
        },
      }

      -- Icons for different DB types
      vim.g.db_ui_icons = {
        expanded = "▾",
        collapsed = "▸",
        saved_query = "",
        new_query = "",
        tables = "",
        buffers = "",
        connection_ok = "✓",
        connection_error = "✗",
      }
    end,
    config = function()
      -- Set up completion for SQL buffers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function(args)
          -- Add dadbod completion source to cmp
          local ok, cmp = pcall(require, "cmp")
          if ok then
            cmp.setup.buffer({
              sources = cmp.config.sources({
                { name = "vim-dadbod-completion" },
              }, {
                { name = "buffer" },
              }),
            })
          end

          -- SQL execution with two-stage transaction safety
          -- Stage 1: Execute previews query (auto-rollback)
          -- Stage 2: Press <leader>xc to commit the previewed query
          local opts = { buffer = args.buf, silent = true }

          -- Store last previewed query for commit
          vim.b.last_sql_preview = nil

          -- Get query text (buffer, line, or visual selection)
          local function get_query(mode)
            if mode == "buffer" then
              return table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
            elseif mode == "line" then
              return vim.api.nvim_get_current_line()
            elseif mode == "visual" then
              local start_pos = vim.fn.getpos("'<")
              local end_pos = vim.fn.getpos("'>")
              local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
              return table.concat(lines, "\n")
            end
          end

          -- Execute = Preview: BEGIN + query + ROLLBACK (see results, store for commit)
          local function execute_query(mode)
            local query = get_query(mode)
            vim.b.last_sql_preview = query  -- Store for potential commit
            vim.cmd("DB BEGIN; " .. query .. "; ROLLBACK;")
            -- Clear notification showing how to commit
            vim.api.nvim_echo({
              { "\n" },
              { "  ╔═══════════════════════════════════════════════════════╗  ", "DiagnosticInfo" },
              { "\n" },
              { "  ║  PREVIEW  ", "DiagnosticInfo" },
              { "Results shown above (auto-rolled back)     ", "Normal" },
              { "║  ", "DiagnosticInfo" },
              { "\n" },
              { "  ║  ", "DiagnosticInfo" },
              { "Press ", "Normal" },
              { "<leader>xc", "DiagnosticWarn" },
              { " to COMMIT this query to database       ", "Normal" },
              { "║  ", "DiagnosticInfo" },
              { "\n" },
              { "  ╚═══════════════════════════════════════════════════════╝  ", "DiagnosticInfo" },
              { "\n" },
            }, true, {})
          end

          -- Commit: Runs the last previewed query with COMMIT
          local function commit_last_query()
            local query = vim.b.last_sql_preview
            if not query then
              vim.notify("No query to commit. Run <leader>xe first to preview.", vim.log.levels.WARN)
              return
            end
            vim.ui.select({ "Yes, COMMIT to database", "No, cancel" }, {
              prompt = "COMMIT this query? Changes will be PERMANENT!",
            }, function(choice)
              if choice == "Yes, COMMIT to database" then
                vim.cmd("DB BEGIN; " .. query .. "; COMMIT;")
                vim.b.last_sql_preview = nil  -- Clear after commit
                vim.api.nvim_echo({
                  { "\n" },
                  { "  ╔══════════════════════════════════════╗  ", "DiagnosticError" },
                  { "\n" },
                  { "  ║       COMMITTED - CHANGES SAVED      ║  ", "DiagnosticError" },
                  { "\n" },
                  { "  ╚══════════════════════════════════════╝  ", "DiagnosticError" },
                  { "\n" },
                }, true, {})
              else
                vim.notify("Cancelled - nothing committed", vim.log.levels.INFO)
              end
            end)
          end

          -- Execute keymaps (preview with auto-rollback)
          vim.keymap.set("n", "<leader>xe", function() execute_query("buffer") end, vim.tbl_extend("force", opts, { desc = "Execute SQL (preview)" }))
          vim.keymap.set("n", "<leader>xl", function() execute_query("line") end, vim.tbl_extend("force", opts, { desc = "Execute SQL line (preview)" }))
          vim.keymap.set("v", "<leader>xe", function() execute_query("visual") end, vim.tbl_extend("force", opts, { desc = "Execute SQL selection (preview)" }))

          -- Commit keymap (commits last previewed query)
          vim.keymap.set("n", "<leader>xc", commit_last_query, vim.tbl_extend("force", opts, { desc = "Commit last previewed SQL" }))
        end,
      })
    end,
  },

  -- Completion source for nvim-cmp
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql", "mysql", "plsql" },
    dependencies = { "tpope/vim-dadbod" },
  },
}
