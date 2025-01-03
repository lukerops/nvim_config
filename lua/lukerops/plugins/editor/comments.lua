local config = require("lukerops.config")

local function toggleCommentLinewise()
  require("Comment.api").toggle.linewise.current()
end

return {
  "numToStr/Comment.nvim",
  keys = {
    { config.keymaps.editor.toggleCommentLinewise, toggleCommentLinewise, desc = "Toggle Comment (Linewise)" },
  },
  opts = {
    mappings = {
      basic = false,
      extra = false,
    },
  },
}
