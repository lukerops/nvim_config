-- TODO: ess código está bugando a exibição de números relativos
-- em filetypes que antes não tinham números de linha
-- Ex: terminal e codecompanion
local group_id = vim.api.nvim_create_augroup('smartnumber', { clear = true})

-- vim.api.nvim_create_autocmd('InsertEnter', {
--   group = group_id,
--   pattern = { '*' },
--   callback = function() vim.opt.relativenumber = false end,
-- })
--
-- vim.api.nvim_create_autocmd('InsertLeave', {
--   group = group_id,
--   pattern = { '*' },
--   callback = function() vim.opt.relativenumber = true end,
-- })
