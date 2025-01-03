local config = require("lukerops.config")

return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  keys = {
    { config.keymaps.editor.openDocumentDiagnostics, "<cmd>Trouble diagnostics<cr>", desc = "Document Diagnostics" },
  },
  opts = {
    use_diagnostic_signs = true,
  },
}
