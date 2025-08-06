local group_id = vim.api.nvim_create_augroup('filetypedetect', { clear = false })

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = group_id,
  pattern = { '*.tofu' },
  callback = function() vim.cmd.setfiletype('opentofu') end,
})
