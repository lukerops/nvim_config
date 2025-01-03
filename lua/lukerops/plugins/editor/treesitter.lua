return {
  "nvim-treesitter/nvim-treesitter",
  module = "nvim-treesitter.configs",
  build = ":TSUpdate",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  event = "BufReadPost",
  opts = {
    ensure_installed = {
      "go",
      "javascript",
      "typescript",
      "python",
      "graphql",
      "json",
      "yaml",
      "lua",
      "bash",
      "dockerfile",
      "query",
      "regex",
      "toml",
      "hcl",
      "terraform",
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true
    },
  },
}
