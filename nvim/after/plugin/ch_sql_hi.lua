-- ClickHouse SQL Syntax Highlighting
-- Adds custom highlight groups for ClickHouse-specific SQL constructs.
-- Applied on every colorscheme change to maintain consistency.

local function apply_highlights()
  local set = vim.api.nvim_set_hl

  -- ClickHouse-specific highlight groups
  set(0, "@ch_engine", { fg = "#e5c07b", bold = true })   -- ENGINE keywords (MergeTree, etc.)
  set(0, "@ch_type", { fg = "#56b6c2", bold = true })     -- ClickHouse types (Enum8, DateTime64)
  set(0, "@ch_func", { fg = "#98c379", italic = true })   -- ClickHouse functions (arrayJoin, quantile)
  set(0, "@ch_clause", { fg = "#c678dd", bold = true })   -- Clauses (ENGINE, SETTINGS, FORMAT)
  set(0, "@ch_enum", { fg = "#ffb86c", bold = true })     -- Enum values ('UNSPECIFIED', 'INTERNAL')
end

-- Apply on colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_highlights,
})

-- Apply immediately
apply_highlights()
