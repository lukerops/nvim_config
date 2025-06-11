local config = require("lukerops.config")

return {
  require("lukerops.plugins.ui.colorscheme"),
  require("lukerops.plugins.ui.indent-blankline"),
  require("lukerops.plugins.ui.lualine"),
  require("lukerops.plugins.ui.render-markdown"),
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        config.keymaps.ui.keymapsHelp,
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    opts = {
      keys = {
        scroll_up = config.keymaps.ui.scrollUp,
        scroll_down = config.keymaps.ui.scrollDown,
      },
    },
  },
}
