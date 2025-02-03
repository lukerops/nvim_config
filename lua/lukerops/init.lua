require("lukerops.lazy")

-- Ensure the ollama is running
require("lukerops.ollama")

local config = require("lukerops.config")

-- Set colorscheme
vim.cmd.colorscheme(config.ui.colorscheme)

-- Enable mouse
vim.opt.mouse = "a"

-- Unify clipboard with system clipboard
vim.opt.clipboard = "unnamedplus"
