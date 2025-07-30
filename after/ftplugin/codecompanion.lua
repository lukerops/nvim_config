local buffer = vim.api.nvim_get_current_buf()

vim.keymap.set('n', '<leader>bff', function()
  local chat = require('codecompanion').buf_get_chat(buffer)
  local completion = require('codecompanion.providers.completion')

  for _, command in ipairs(require('codecompanion.providers.completion').slash_commands()) do
    if command.label == '/buffer' then
      completion.slash_commands_execute(command, chat)
      return
    end
  end
end, {
  buffer = buffer,
  desc = 'Code Companion: Find Files',
})
