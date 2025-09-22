return {
  'folke/tokyonight.nvim',
  tag = 'v4.12.0',
  opts = {
    style = 'night'
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)

    -- define o tema
    vim.cmd.colorscheme('tokyonight-night')
  end
}
