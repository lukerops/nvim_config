local config = require("lukerops.config")

return {
  "williamboman/mason.nvim",
  -- event = "VeryLazy",
  cmd = { "Mason" },
  opts = function()
    local registries = {"github:mason-org/mason-registry"}

    if vim.fn.executable("yq") ~= 1 then
      vim.notify(
        "Instale o yq para usar o Mason com suporte a repositorio local.",
        vim.log.levels.WARN
      )
    else
      table.insert(registries, "file:" .. vim.fn.stdpath("config") .. "/mason-registry")
    end

    return {
      ui = { border = config.ui.border },
      registries = registries,
    }
  end,
}
