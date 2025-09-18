return {
  'zbirenbaum/copilot.lua',
  -- event = { 'BufReadPre', 'BufNewFile' },
  ft = { 'typescript' },
  opts = {
    suggestion = { enabled = true, auto_trigger = true },
    panel = { enabled = false },
  }
}
