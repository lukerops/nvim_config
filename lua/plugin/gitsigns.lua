return {
  'lewis6991/gitsigns.nvim',
  tag = 'v1.0.2',
  opts = {
    current_line_blame = true,
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    current_line_blame_opts = {
      delay = 0,
    },
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    signs_staged = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
    },
  }
}
