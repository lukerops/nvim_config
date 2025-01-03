require("lukerops.lazy")

local config = require("lukerops.config")

-- Set colorscheme
vim.cmd.colorscheme(config.ui.colorscheme)

-- Enable mouse
vim.opt.mouse = "a"

-- Unify clipboard with system clipboard
vim.opt.clipboard = "unnamedplus"
