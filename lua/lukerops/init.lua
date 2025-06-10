require("lukerops.lazy")

local config = require("lukerops.config")

-- Define o tema
vim.cmd.colorscheme(config.ui.colorscheme)

-- Habilita mouse
vim.opt.mouse = "a"

-- Unifica o clipboard com o do sistema
vim.opt.clipboard = "unnamedplus"

vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
