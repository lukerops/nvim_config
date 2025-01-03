local separator = { right = '', left = '' }

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = true,
      -- component_separators = {"", ""},
      -- section_separators = {"", ""},
      -- disabled_filetypes = {},
      component_separators = '',
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {
          "mason",
          "lazy",
        },
      },
    },
    sections = {
      lualine_a = { { 'mode', separator = separator } },
      lualine_b = {},
      lualine_c = { 'diff', "diagnostics" },
      lualine_x = { "filetype" },
      lualine_y = { "progress" },
      lualine_z = { { 'location', separator = separator }, }
    },
    tabline = {
      lualine_a = {},
      lualine_b = { { 'branch', separator = separator } },
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = {},
      lualine_y = {},
      lualine_z = { { 'tabs', separator = separator } }
    },
    extensions = {
      {
        sections = {
          lualine_a = { {
            function()
              return vim.fn.fnamemodify(require("oil").get_current_dir(), ':~') or ""
            end,
            separator = separator
          } }
        },
        filetypes = { "oil" }
      },
      {
        sections = {
          lualine_a = { { 'mode', separator = separator } },
        },
        filetypes = { "toggleterm" },
      },
    },
  }
}
