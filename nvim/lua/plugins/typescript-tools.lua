return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact", "svelte" },
  opts = {
    settings = {
      -- spawn additional tsserver instance for type checking
      separate_diagnostic_server = true,
      -- enable completion in strings/comments
      complete_function_calls = true,
      -- inlay hints
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      },
    },
  },
}
