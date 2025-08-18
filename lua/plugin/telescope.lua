return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  keys = {
    { '<leader>/', '<cmd>Telescope live_grep<cr>', desc = 'Find in Files (Grep)' },
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
    { '<leader>ch', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
    { '<leader>km', '<cmd>Telescope keymaps<cr>', desc = 'Key Maps' },
  },
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup({
      defaults = {
        vimgrep_arguments = {
          'rg', '--color=never', '--no-heading', '--with-filename',
          '--line-number', '--column', '--smart-case', '--hidden',
          '--glob', '!**/.git/*',
        },
        mappings = {
          i = {
            ['<C-Up>'] = actions.preview_scrolling_up,
            ['<C-Down>'] = actions.preview_scrolling_down,
          },
          n = {
            ['<C-Up>'] = actions.preview_scrolling_up,
            ['<C-Down>'] = actions.preview_scrolling_down,
          },
        },
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        },
        buffers = {
          ignore_current_buffer = true,
          sort_mru = true,
          sort_lastused = true,
          mappings = {
            i = { ['<C-d>'] = actions.delete_buffer + actions.move_to_top },
            n = { ['<C-d>'] = actions.delete_buffer + actions.move_to_top },
          },
        },
      },
    })
  end
}
