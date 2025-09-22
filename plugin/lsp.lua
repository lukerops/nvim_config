-- https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    -- if client:supports_method('textDocument/completion') then
    --   vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    -- end

    if client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = event.buf,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end

    local bufmap = function(mode, rhs, lhs)
      vim.keymap.set(mode, rhs, lhs, { buffer = event.buf })
    end

    -- keymaps
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover({ border = \'rounded\' })<cr>')
    bufmap('i', '<c-space>', '<cmd>lua vim.lsp.completion.get()<cr>')
    bufmap({ 'i', 's' }, '<c-s>', '<cmd>lua vim.lsp.buf.signature_help({ border = \'rounded\' })<cr>')
    bufmap('n', 'gd', '<cmd>Trouble lsp_definitions<cr>')
    bufmap('n', 'grr', '<cmd>Trouble lsp_references<cr>')
  end,
})
