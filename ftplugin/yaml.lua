vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.lsp.config('yamlls', {
  settings = {
    yaml = {
      schemas = {
        ['https://www.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
        ['https://raw.githubusercontent.com/compose-spec/compose-go/master/schema/compose-spec.json'] = '**/docker-compose*.{yml,yaml}',
      },
    },
  },
})

vim.lsp.enable('yamlls')
