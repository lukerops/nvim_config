local config = require("lukerops.config")

local lspconfig_to_mason = {
  lua_ls = 'lua-language-server',
  pylsp = 'python-language-server',
  gopls = 'gopls',
  tofu_ls = 'tofu-ls',
  terraformls = 'terraform-ls',
}

return {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo", "LspInstall", "LspStart", },
  event = { "BufReadPre", "BufNewFile", },
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
  },
  config = function()
    local lspconfig = require('lspconfig')
    local mason = require('mason-registry')

    local ensure_installed = {
      "lua_ls",
      -- "pylsp",
      "gopls",
      "tofu_ls",
      'terraformls',
    }

    local packages = mason.get_installed_package_names()
    for _, lsp_server in ipairs(ensure_installed) do
      local package_name = lspconfig_to_mason[lsp_server]

      local found = false
      for _, installed_package in ipairs(packages) do
        if installed_package == package_name then
          found = true
          break
        end
      end

      if not found then
        local package = mason.get_package(package_name)
        package:install()
      end

      vim.lsp.enable(lsp_server)
      vim.lsp.config(lsp_server, {})
    end

    -- Add cmp_nvim_lsp capabilities settings to lspconfig
    lspconfig.util.default_config.capabilities = require('blink.cmp')
        .get_lsp_capabilities(lspconfig.util.default_config.capabilities)

    -- cria um on_attach default
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local id = vim.tbl_get(event, 'data', 'client_id')
        local client = vim.lsp.get_client_by_id(id) or {}

        local bufnr = event.buf
        local opts = { buffer = bufnr }

        -- ativa o inlay hint
        if config.editor.lsp.enableInlayHints and client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, opts)
        end

        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = config.ui.border }) end, opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>Trouble lsp_references<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      end,
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = config.ui.border,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = config.icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = config.icons.diagnostics.Warn,
          [vim.diagnostic.severity.HINT] = config.icons.diagnostics.Hint,
          [vim.diagnostic.severity.INFO] = config.icons.diagnostics.Info,
        }
      }
    })
  end,
}
