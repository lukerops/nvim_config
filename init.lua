local border = 'rounded'

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
  spec = {
    {
      'folke/tokyonight.nvim',
      opts = { style = 'night' },
    },
    {
      'stevearc/oil.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    },
    'nvim-treesitter/nvim-treesitter',
    'neovim/nvim-lspconfig',
    'zbirenbaum/copilot.lua',
    'MeanderingProgrammer/render-markdown.nvim',
    'olimorris/codecompanion.nvim',
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { 'habamax' } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  ui = { border = border },
})

---------------
--- plugins ---
---------------

vim.lsp.enable({ 'ts_ls' })

require('oil').setup({ float = { border = border } })
require('render-markdown').setup({
  completions = { lsp = { enabled = true } },
  file_types = { 'markdown', 'codecompanion' },
})

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

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'go', 'javascript', 'typescript', 'python', 'lua', 'bash',
    'graphql', 'json', 'yaml', 'toml',
    'dockerfile', 'hcl', 'terraform',
  },
  highlight = { enable = true },
  indent = { enable = true },
})

require('copilot').setup({
  suggestion = { enabled = true, auto_trigger = true },
  panel = { enabled = false },
})

require('codecompanion').setup({
  display = {
    action_palette = { provider = 'telescope' },
    chat = {
      start_in_insert_mode = true,
      window = {
        layout = 'vertical',
        position = 'right',
        border = border,
        width = 0.3,
        opts = {
          -- https://neovim.io/doc/user/options.html#'number'
          number = false,
          relativenumber = false,
        }
      },
    },
  },
  strategies = { chat = { adapter = 'copilot' } },
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

vim.keymap.set('n', '<leader>fe', '<cmd>Oil<cr>', { desc = 'File Explorer' })
vim.keymap.set('n', '<leader>/', '<cmd>Telescope live_grep<cr>', { desc = 'Find in Files (Grep)' })
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Buffers' })
vim.keymap.set('n', '<leader>ch', '<cmd>Telescope command_history<cr>', { desc = 'Command History' })
vim.keymap.set('n', '<leader>/', '<cmd>Telescope keymaps<cr>', { desc = 'Key Maps' })

vim.keymap.set('n', '<leader>ai', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle Code Companion Chat' })

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
    bufmap('n', 'gd', function() vim.lsp.buf.definition() end)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'codecompanion' },
  callback = function(event)
    vim.keymap.set('n', '<leader>bff', function()
      local chat = require('codecompanion').buf_get_chat(event.buf)
      local completion = require('codecompanion.providers.completion')

      for _, command in ipairs(require('codecompanion.providers.completion').slash_commands()) do
        if command.label == '/buffer' then
          completion.slash_commands_execute(command, chat)
          return
        end
      end
    end, {
      buffer = event.buf,
      desc = 'Code Companion: Find Files',
    })
  end,
})
