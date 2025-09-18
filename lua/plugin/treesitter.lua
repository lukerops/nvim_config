return {
  'nvim-treesitter/nvim-treesitter',
  tag = 'v0.10.0',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'go', 'javascript', 'typescript', 'python', 'lua', 'bash',
      'graphql', 'json', 'yaml', 'toml',
      'dockerfile', 'hcl', 'terraform',
    },
    highlight = { enable = true },
    indent = { enable = true },
  }
}
