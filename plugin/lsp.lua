local border = 'rounded'

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
