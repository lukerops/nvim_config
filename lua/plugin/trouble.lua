return {
  'folke/trouble.nvim',
  tag = 'v3.7.1',
  cmd = { 'TroubleToggle', 'Trouble' },
  keys = {
    { '<leader>dd', '<cmd>Trouble diagnostics<cr>', desc = 'Document Diagnostics' },
  },
  opts = {
    use_diagnostic_signs = true,
  },
}
