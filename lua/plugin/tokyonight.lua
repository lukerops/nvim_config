return {
  'folke/tokyonight.nvim',
  opts = {
    style = 'night'
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)

    -- define o tema
    vim.cmd.colorscheme('tokyonight-night')
  end
}
