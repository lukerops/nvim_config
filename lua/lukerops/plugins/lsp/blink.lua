local config = require("lukerops.config")

local enable_copilot = os.getenv('USER') == "lucas.cvieira"

local function findItemKind(CompletionItemKind, kind)
  for index, kind_name in ipairs(CompletionItemKind) do
    if kind_name == kind then
      return index
    end
  end

  return 0
end

local function createItemKind(kind)
  local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
  local kind_idx = findItemKind(CompletionItemKind, kind)

  if kind_idx == 0 then
    kind_idx = #CompletionItemKind + 1
    CompletionItemKind[kind_idx] = kind
  end

  return kind_idx
end

local function setItemKind(kind)
  return function(_, items)
    local kind_idx = createItemKind(kind)

    for _, item in ipairs(items) do
      item.kind = kind_idx
    end

    return items
  end
end

return {
  'saghen/blink.cmp',
  dependencies = {
    -- optional: provides snippets for the snippet source
    'rafamadriz/friendly-snippets',
    {
      "giuxtaposition/blink-cmp-copilot",
      cond = enable_copilot,
      dependencies = { {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        -- event = "InsertEnter",
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
        }
      } }
    },
  },

  -- use a release tag to download pre-built binaries
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = function()
    local sources = {'lsp', 'path', 'snippets', 'buffer'}
    local providers = {
      lsp = {
        name = 'LSP',
        module = 'blink.cmp.sources.lsp',
        fallbacks = { 'buffer' },
        async = true,
        transform_items = function(_, items)
          local kind_idx = createItemKind("AI")
          local lsp_ai_id = 0

          local lsp_ai_clients = vim.lsp.get_clients({ name = "lsp_ai" })
          if #lsp_ai_clients == 1 then
            lsp_ai_id = lsp_ai_clients[1].id
          end

          for _, item in ipairs(items) do
            -- demote snippets
            if item.kind == require('blink.cmp.types').CompletionItemKind.Snippet then
              item.score_offset = item.score_offset - 3
            end

            -- set kind to AI for lsp_ai sources
            if item.client_id == lsp_ai_id then
              item.kind = kind_idx
              item.score_offset = item.score_offset + 5
            end
          end

          -- filter out text items, since we have the buffer source
          return vim.tbl_filter(
            function(item) return item.kind ~= require('blink.cmp.types').CompletionItemKind.Text end,
            items
          )
        end,
      },
    }

    -- habilita o copilot
    if enable_copilot then
      table.insert(sources, "copilot")
      providers["copilot"] = {
        name = "copilot",
        module = "blink-cmp-copilot",
        score_offset = 100,
        async = true,
        transform_items = setItemKind("Copilot"),
      }
    end

    -- habilita codecompanion
    table.insert(sources, "codecompanion")
    providers["codecompanion"] = {
      name = "CodeCompanion",
      module = "codecompanion.providers.completion.blink",
    }


    return {
      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'cancel', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },

        ['<C-f>'] = { 'snippet_forward', 'fallback' },
        ['<C-b>'] = { 'snippet_backward', 'fallback' },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },

        ['<C-Up>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-Down>'] = { 'scroll_documentation_down', 'fallback' },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
        kind_icons = config.icons.kinds,
      },

      completion = {
        menu = {
          auto_show = function(ctx, _) return ctx.mode ~= 'cmdline' end,
          border = config.ui.border,
          draw = { columns = { { 'label', 'label_description', gap = 1 }, { "kind_icon", "kind" } } }
        },
        documentation = {
          auto_show = true,
          window = { border = config.ui.border },
        },
        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = true },
        -- Avoid unnecessary request
        trigger = { prefetch_on_insert = false },
      },
      signature = { window = { border = config.ui.border } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = sources,
        providers = providers,
      },
    }
  end,
  opts_extend = { "sources.default" }
}
