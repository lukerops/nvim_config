-- Esse arquivo substitui a função `on_attach` do ts_ls que foi configurado
-- pelo `lspconfig`.
--
-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ts_ls.lua

local function code_action(opts)
  local opts = opts or {}

  if opts.async then
    vim.lsp.buf.code_action({ context = { only = { opts.kind } }, apply = true })
  else
    -- implementa a operação de `code_action` manualmente para
    -- que ela seja sincrona e não deixe o buffer sempre com
    -- modificações pendentes
    --
    -- https://github.com/fnune/codeactions-on-save.nvim/blob/main/lua/codeactions-on-save/main.lua#L15-L37
    -- https://github.com/neovim/neovim/blob/a9a4c271b13fffba2a21567c86b0f40ae4c180a1/runtime/lua/vim/lsp/buf.lua#L1275
    local offset_encoding = opts.offset_encoding or 'utf-16'
    local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()

    local params = vim.lsp.util.make_range_params(0, offset_encoding)
    params.context = { only = { opts.kind }, diagnostics = {} }

    local results = vim.lsp.buf_request_sync(bufnr, 'textDocument/codeAction', params, 1000)
    for _, result in pairs(results or {}) do
      for _, action in pairs(result.result or {}) do
        if action.kind == opts.kind then
          vim.lsp.util.apply_workspace_edit(action.edit, offset_encoding)
        end
      end
    end
  end
end

return {
  on_attach = function(client, bufnr)
    -- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
    -- `vim.lsp.buf.code_action()` if specified in `context.only`.
    vim.api.nvim_buf_create_user_command(bufnr, 'LspTypescriptSourceAction', function()
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, 'source.')
      end, client.server_capabilities.codeActionProvider.codeActionKinds)

      vim.lsp.buf.code_action({ context = { only = source_actions } })
    end, {})

    -- :lua vim.print(vim.lsp.get_active_clients()[1].server_capabilities)
    vim.api.nvim_buf_create_user_command(bufnr, 'OrganizeImports', function()
      code_action({
        kind = 'source.organizeImports.ts',
        async = true,
      })
    end, {})

    -- organiza os imports automaticamente ao salvar o buffer
    vim.api.nvim_create_autocmd('BufWritePre', {
      desc = 'Organize imports on save',
      buffer = bufnr,
      callback = function(event)
        code_action({
          kind = 'source.organizeImports.ts',
          async = false,
          offset_encoding = client.offset_encoding,
          bufnr = event.buf,
        })
        code_action({
          kind = 'source.removeUnusedImports.ts',
          async = false,
          offset_encoding = client.offset_encoding,
          bufnr = event.buf,
        })
      end,
    })
  end,
}
