return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
  },
  opts = {
    display = {
      action_palette = {
	provider = "telescope",
      },
      chat = {
	show_references = true,
	window = {
	  border = require("lukerops.config").ui.border,
	},
      },
    },
    opts = {
      language = "Português (Brasil)", -- Default is "English"
    },
    strategies = {
      chat = {
	adapter = "ollama",
	slash_commands = {
	  ["buffer"] = { opts = { provider = "telescope" } },
	  ["file"] = { opts = { provider = "telescope" } },
	  ["help"] = { opts = { provider = "telescope" } },
	  ["symbols"] = { opts = { provider = "telescope" } },
	},
      },
    },
    adapters = {
      ollama = function()
	return require("codecompanion.adapters").extend("ollama", {
	  env = {
	    url = "http://localhost:11434",
	    api_key = "OLLAMA_API_KEY",
	  },
	  headers = {
	    ["Content-Type"] = "application/json",
	    ["Authorization"] = "Bearer ${api_key}",
	  },
	  parameters = {
	    sync = true,
	  },
	})
      end,
    },
  }
}
