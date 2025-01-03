local config = require("lukerops.config")

local filePreferences = {}
if config.editor.lsp.enableInlayHints then
  filePreferences.includeInlayParameterNameHints = "all"
  filePreferences.includeInlayFunctionParameterTypeHints = true
  filePreferences.includeInlayVariableTypeHints = true
  filePreferences.includeInlayPropertyDeclarationTypeHints = true
  filePreferences.includeInlayFunctionLikeReturnTypeHints = true
  filePreferences.includeInlayEnumMemberValueHints = true
end

return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  opts = {
    settings = {
      tsserver_file_preferences = filePreferences,
      tsserver_format_options = {
        tabSize = 2,
        indentSize = 2,
      },
    },
  },
}
