local config = require("lukerops.config")

return {
  "lukas-reineke/indent-blankline.nvim",
  enabled = config.ui.indentationGuide,
  event = "BufReadPre",
  main = "ibl",
  opts = {},
}
