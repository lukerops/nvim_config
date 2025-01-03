local config = require("lukerops.config")

return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { config.keymaps.fileExplorer.open, "<cmd>Oil<cr>", desc = "File Explorer" },
  },
  opts = {
    float = {
      border = require("lukerops.config").ui.border,
    },
  },
}
