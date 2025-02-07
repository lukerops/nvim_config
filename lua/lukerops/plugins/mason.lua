local config = require("lukerops.config")

return {
  "williamboman/mason.nvim",
  -- event = "VeryLazy",
  cmd = { "Mason" },
  opts = {
    ui = { border = config.ui.border },
    registries = {
        "github:mason-org/mason-registry",
	"file:" .. vim.fn.stdpath("config") .. "/mason-registry"
    },
  },
}
