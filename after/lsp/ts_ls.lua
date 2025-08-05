-- Esse arquivo substitui a função `on_attach` do ts_ls que foi configurado
-- pelo `lspconfig`.
--
-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ts_ls.lua

return {
  on_attach = function(client, bufnr)
    -- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
    -- `vim.lsp.buf.code_action()` if specified in `context.only`.
    vim.api.nvim_buf_create_user_command(bufnr, 'LspTypescriptSourceAction', function()
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, 'source.')
      end, client.server_capabilities.codeActionProvider.codeActionKinds)

      vim.lsp.buf.code_action({
        context = {
          only = source_actions,
        },
      })
    end, {})

    -- :lua vim.print(vim.lsp.get_active_clients()[1].server_capabilities)
    vim.api.nvim_buf_create_user_command(bufnr, 'OrganizeImports', function()
      vim.lsp.buf.code_action({
        context = { only = { 'source.organizeImports.ts' } },
        apply = true,
      })
    end, {})

    -- organiza os imports automaticamente ao salvar o buffer
    vim.api.nvim_create_autocmd('BufWritePre', {
      desc = 'Organize imports on save',
      buffer = bufnr,
      callback = function(event)
        -- implementa a operação de `code_action` manualmente para
        -- que ela seja sincrona e não deixe o buffer sempre com
        -- modificações pendentes
        --
        -- https://github.com/fnune/codeactions-on-save.nvim/blob/main/lua/codeactions-on-save/main.lua#L15-L37
        -- https://github.com/neovim/neovim/blob/a9a4c271b13fffba2a21567c86b0f40ae4c180a1/runtime/lua/vim/lsp/buf.lua#L1275
        local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
        params.context = { only = { 'source.organizeImports.ts' }, diagnostics = {} }

        local results = vim.lsp.buf_request_sync(event.buf, 'textDocument/codeAction', params, 1000)
        for _, result in pairs(results or {}) do
          for _, action in pairs(result.result or {}) do
            if action.kind == 'source.organizeImports.ts' then
              vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
            end
          end
        end
      end,
    })
  end,
}
