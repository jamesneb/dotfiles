-- Emmet
-- Fast HTML/CSS generation using abbreviations.
-- Type abbreviation then Ctrl+e, to expand.
-- Example: div.container>ul>li*3 expands to nested HTML structure.

return {
  "mattn/emmet-vim",
  ft = { "html", "css", "javascriptreact", "typescriptreact", "svelte" },
  init = function()
    -- Leader key for emmet expansion
    vim.g.user_emmet_leader_key = "<C-e>"
  end,
}
