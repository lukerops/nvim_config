return {
  'olimorris/codecompanion.nvim',
  tag = 'v17.14.0',
  keys = {
    { '<leader>ai', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Toggle Code Companion Chat' },
  },
  opts = {
    display = {
      action_palette = { provider = 'telescope' },
      chat = {
        start_in_insert_mode = true,
        window = {
          layout = 'vertical',
          position = 'right',
          border = 'rounded',
          width = 0.3,
          opts = {
            -- https://neovim.io/doc/user/options.html#'number'
            number = false,
            relativenumber = false,
          }
        }
      }
    },
    strategies = { chat = { adapter = 'copilot' } },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        }
      }
    }
  }
}
