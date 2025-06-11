local config = require("lukerops.config")

return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  dependencies = { "folke/trouble.nvim", "nvim-telescope/telescope.nvim" },
  keys = {
    {
      config.keymaps.editor.toggleTodoComments,
      "<cmd>Trouble todo toggle<cr>",
      desc = "Toggle Todo Comments",
    },
    {
      config.keymaps.editor.toggleTodoFixComments,
      "<cmd>Trouble todo toggle filter={tag={TODO,FIX,FIXME}}<cr>",
      desc = "Toggle Todo Fix Comments",
    },
    {
      config.keymaps.search.todoComments,
      "<cmd>TodoTelescope<cr>",
      desc = "Search Todo Comments",
    },
  },
  opts = {},
}
