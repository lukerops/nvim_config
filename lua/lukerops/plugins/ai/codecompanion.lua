local config = require("lukerops.config")

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Code Companion Chat" },
    { "<leader>aia", "<cmd>CodeCompanionActions<cr>", desc = "Open Code Companion Actions" },
  },
  cmd = { "CodeCompanionChat", "CodeCompanionActions" },
  opts = {
    display = {
      action_palette = {
	provider = "telescope",
      },
      chat = {
	show_references = true,
        debug_window = {
          width = vim.o.columns,
          height = math.floor(vim.o.lines * 0.93),
        },
	window = {
          layout = config.ui.ai.chat.layout,
	  border = config.ui.border,
          width = 0.6,
          height = 0.8,
	  opts = {
	    -- https://neovim.io/doc/user/options.html#'number'
            number = config.ui.ai.chat.showLineNumber,
	  },
	},
      },
    },
    strategies = {
      chat = {
	-- adapter = "ollama",
	adapter = "copilot",
        roles = {
          llm = function(adapter)
            return adapter.formatted_name
          end,
          user = "lukerops",
        },
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
	  },
	})
      end,
      openai_ollama = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          schema = {
            model = {
              default = "qwen2.5-coder:3b",  -- define llm model to be used
            },
          },
        })
      end,
      openwebui = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          env = {
            url = "http://chat.lukerops.com/ollama", -- optional: default value is ollama url http://127.0.0.1:11434
            api_key = os.getenv("OPENWEBUI_API_KEY"), -- optional: if your endpoint is authenticated
            chat_url = "/v1/chat/completions", -- optional: default value, override if different
            models_endpoint = "/v1/models", -- optional: attaches to the end of the URL to form the endpoint to retrieve models
          },
          schema = {
            model = {
              default = "qwen2.5-coder:3b",  -- define llm model to be used
            },
          },
        })
      end,
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },
  }
}
