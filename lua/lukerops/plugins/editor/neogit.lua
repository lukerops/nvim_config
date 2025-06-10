local config = require("lukerops.config")

return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  keys = {
    { config.keymaps.editor.openGit, function() require("neogit").open() end, desc = "Open Git Interface" },
  },
  cmd = { "Neogit" },
}
