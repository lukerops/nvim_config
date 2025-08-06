-- registra que o tofu vai usar o mesmo treesitter
-- que o terraform
vim.treesitter.language.register('terraform', 'opentofu')

vim.lsp.enable('tofu_ls')
