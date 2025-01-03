local config = require("lukerops.config")

return {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    {
      "saadparwaiz1/cmp_luasnip",
      dependencies = { {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
      } },
    },
    {
      "zbirenbaum/copilot-cmp",
      dependencies = { {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        -- event = "InsertEnter",
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
        }
      } },
      config = true,
    },
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "copilot" },
      }, {
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
      }),
      mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        [config.keymaps.editor.autoComplete.select] = cmp.mapping.confirm({ select = false }),

        -- Ctrl+Space to trigger completion menu
        [config.keymaps.editor.autoComplete.open] = cmp.mapping.complete(),
        [config.keymaps.editor.autoComplete.close] = cmp.mapping.abort(),

        -- Navigate between snippet placeholder
        -- ["<C-f>"] = cmp_action.luasnip_jump_forward(),
        -- ["<C-b>"] = cmp_action.luasnip_jump_backward(),

        -- scroll up and down the documentation window
        ['<C-Up>'] = cmp.mapping.scroll_docs(-4),
        ['<C-Down>'] = cmp.mapping.scroll_docs(4),
      }),
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          require("copilot_cmp.comparators").prioritize,
          -- Below is the default comparitor list and order for nvim-cmp
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          -- cmp.config.compare.scopes,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          -- cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "cmdline" }
      }
    })

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" }
      }
    })
  end,
}
