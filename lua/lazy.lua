local M = {}

function M.bootstrap()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'

  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
      vim.notify('Failed to bootstrap the plugin manager:\n' .. out)
      os.exit(1)
    end
  end

  vim.opt.rtp:prepend(lazypath)
end

function M.setup(opts)
  M.bootstrap()
  -- Clear the lazy module cache to ensure it reloads with the new setup
  package.loaded['lazy'] = nil

  -- Load the lazy module with the provided options
  require('lazy').setup(opts or {})
end

return M
