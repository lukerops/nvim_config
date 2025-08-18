return {
  'folke/trouble.nvim',
  cmd = { 'TroubleToggle', 'Trouble' },
  keys = {
    { '<leader>dd', '<cmd>Trouble diagnostics<cr>', desc = 'Document Diagnostics' },
  },
  opts = {
    use_diagnostic_signs = true,
  },
}
