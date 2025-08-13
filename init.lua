local border = 'rounded'

--------------------
--- nvim configs ---
--------------------

-- habilita a numeração de linhas
vim.opt.number = true
-- mostra a numeraçao relativa a linha atual
vim.opt.relativenumber = true
-- desabilita o arquivo de swap
vim.opt.swapfile = false
-- habilita mouse
vim.opt.mouse = 'a'
-- unifica o clipboard com o do sistema
vim.opt.clipboard = 'unnamedplus'
-- faz o neovim definir o titulo da janela
vim.opt.title = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }

vim.diagnostic.config({
  -- update_in_insert = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = border,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
    }
  }
})

---------------
--- keymaps ---
---------------

vim.keymap.set('n', '<c-w>d', function() vim.diagnostic.open_float({ border = 'rounded' }) end,
  { desc = 'Show Diagnostics' })

vim.keymap.set('n', '<M-Up>', ':m .-2<CR>==')
vim.keymap.set('n', '<M-Down>', ':m .+1<CR>==')
vim.keymap.set('i', '<M-Up>', '<Esc>:m .-2<CR>==gi')
vim.keymap.set('i', '<M-Down>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('v', '<M-Up>', ':m \'<-2<CR>gv=gv')
vim.keymap.set('v', '<M-Down>', ':m \'>+1<CR>gv=gv')

---------------------
--- pluginmanager ---
---------------------

require('pluginmanager').setup({
  'nvim-tree/nvim-web-devicons',
  'nvim-lua/plenary.nvim',
  'folke/tokyonight.nvim',
  { 'stevearc/oil.nvim', tag = 'v2.15.0' },
  { 'nvim-treesitter/nvim-treesitter', tag = 'v0.10.0', run = ':TSUpdate' },
  { 'neovim/nvim-lspconfig', tag = 'v2.4.0' },
  'zbirenbaum/copilot.lua',
  { 'MeanderingProgrammer/render-markdown.nvim', tag = 'v8.7.0' },
  { 'olimorris/codecompanion.nvim', tag = 'v17.14.0' },
  { 'williamboman/mason.nvim', tag = 'v2.0.1' },
  { 'lewis6991/gitsigns.nvim', tag = 'v1.0.2' },
  'giuxtaposition/blink-cmp-copilot',
  { 'nvim-neotest/nvim-nio', tag = 'v1.10.1' },
  { 'nvim-neotest/neotest', tag = 'v5.9.1' },
  'nvim-neotest/neotest-jest',
  { 'mfussenegger/nvim-dap', tag = '0.10.0' },
  'rcarriga/nvim-dap-ui',
  'rafamadriz/friendly-snippets',
  { 'saghen/blink.cmp', tag = 'v1.6.0' },
  { 'nvim-telescope/telescope.nvim', tag = '0.1.8' },
})
