local config = require("lukerops.config")

return {
  "williamboman/mason.nvim",
  -- event = "VeryLazy",
  cmd = { "Mason" },
  opts = {
    ui = { border = config.ui.border },
  },
}
