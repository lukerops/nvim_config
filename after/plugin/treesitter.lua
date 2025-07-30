require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'go', 'javascript', 'typescript', 'python', 'lua', 'bash',
    'graphql', 'json', 'yaml', 'toml',
    'dockerfile', 'hcl', 'terraform',
  },
  highlight = { enable = true },
  indent = { enable = true },
})
