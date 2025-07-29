local border = 'rounded'

---------------
--- plugins ---
---------------

local plugins = {
  {
    'folke/tokyonight.nvim',
    lazy = true,
    opts = {
      style = 'night',
    },
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>fe', '<cmd>Oil<cr>', desc = 'File Explorer' },
    },
    opts = { float = { border = border } },
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    cmd = { 'Telescope' },
    keys = {
      { '<leader>/',  '<cmd>Telescope live_grep<cr>',       desc = 'Find in Files (Grep)' },
      { '<leader>ff', '<cmd>Telescope find_files<cr>',      desc = 'Find Files' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>',         desc = 'Buffers' },
      { '<leader>ch', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
      { '<leader>km', '<cmd>Telescope keymaps<cr>',         desc = 'Key Maps' },
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
              i = {
                ['<C-d>'] = actions.delete_buffer + actions.move_to_top,
              },
              n = {
                ['<C-d>'] = actions.delete_buffer + actions.move_to_top,
              },
            },
          },
        },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter.configs',
    build = ':TSUpdate',
    event = 'BufReadPost',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    opts = {
      ensure_installed = {
        'go', 'javascript', 'typescript', 'python', 'lua', 'bash',
        'graphql', 'json', 'yaml', 'toml',
        'dockerfile', 'hcl', 'terraform',
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.lsp.enable({ 'ts_ls' })
    end,
  }
}

-----------------
--- lazy.nvim ---
-----------------

-- por enquanto vou utilizar o lazy.nvim para gerenciar os plugins
-- na versão 0.12.0 o neovim já vem com suporte a plugins nativos

-- https://github.com/SylvanFranklin/.config/blob/main/nvim/init.lua
-- https://bower.sh/nvim-builtin-plugin-mgr

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out,                            'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup({
  spec = { plugins },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { 'habamax' } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  ui = { border = border },
})

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
-- define o tema
vim.cmd.colorscheme('tokyonight-night')

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

vim.keymap.set('n', '<c-w>d', function()
  vim.diagnostic.open_float({ border = border })
end, { desc = 'Show Diagnostics' })

--------------------
--- autocommands ---
--------------------

-- https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    local bufmap = function(mode, rhs, lhs)
      vim.keymap.set(mode, rhs, lhs, { buffer = event.buf })
    end

    -- keymaps
    bufmap('n', 'K', function() vim.lsp.buf.hover({ border = border }) end)
    bufmap('i', '<c-space>', function() vim.lsp.completion.get() end)
    bufmap({ 'i', 's' }, '<c-s>', function() vim.lsp.buf.signature_help({ border = border }) end)
  end,
})
