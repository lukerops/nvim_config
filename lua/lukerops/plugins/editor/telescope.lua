local config = require("lukerops.config")

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  cmd = { "Telescope" },
  keys = {
    { config.keymaps.search.inFiles,        "<cmd>Telescope live_grep<cr>",       desc = "Find in Files (Grep)" },
    { config.keymaps.search.files,          "<cmd>Telescope find_files<cr>",      desc = "Find Files" },
    { config.keymaps.search.buffers,        "<cmd>Telescope buffers<cr>",         desc = "Buffers" },
    { config.keymaps.search.gitBranches,    "<cmd>Telescope git_branches<CR>",    desc = "Git Branches" },
    { config.keymaps.search.gitCommits,     "<cmd>Telescope git_commits<CR>",     desc = "Git Commits" },
    { config.keymaps.search.gitStatus,      "<cmd>Telescope git_status<CR>",      desc = "Git Status" },
    { config.keymaps.search.commandHistory, "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { config.keymaps.search.helpTags,       "<cmd>Telescope help_tags<cr>",       desc = "Help Pages" },
    { config.keymaps.search.keymaps,        "<cmd>Telescope keymaps<cr>",         desc = "Key Maps" },
  },
  config = function()
    local actions = require("telescope.actions")
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          "rg", "--color=never", "--no-heading", "--with-filename",
          "--line-number", "--column", "--smart-case", "--hidden",
          "--glob", "!**/.git/*",
        },
        mappings = {
          i = {
            -- ["<c-t>"] = require("trouble.sources.telescope").open,
            ["<C-Up>"] = actions.preview_scrolling_up,
            ["<C-Down>"] = actions.preview_scrolling_down,
          },
          n = {
            ["<C-Up>"] = actions.preview_scrolling_up,
            ["<C-Down>"] = actions.preview_scrolling_down,
          },
        },
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        buffers = {
          ignore_current_buffer = true,
          sort_mru = true,
          sort_lastused = true,
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
            },
            n = {
              ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
      },
    })
  end,
}
