local config = require("lukerops.config")

local function setItemKind(kind)
  return function(_, items)
    local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
    local kind_idx = #CompletionItemKind + 1
    CompletionItemKind[kind_idx] = kind
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
  opts = {
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
      default = {
	'lsp', 'path', 'snippets', 'buffer',
        "copilot", "codecompanion",
	-- "minuet",
      },
      providers = {
	codecompanion = {
          name = "CodeCompanion",
          module = "codecompanion.providers.completion.blink",
        },
	copilot = {
	  name = "copilot",
	  module = "blink-cmp-copilot",
	  score_offset = 100,
	  -- async = true,
	  transform_items = setItemKind("Copilot"),
	},
	-- minuet = {
	--   name = 'minuet',
	--   module = 'minuet.blink',
	--   score_offset = 100, -- Gives minuet higher priority among suggestions
	--   -- async = true,
	--   transform_items = setItemKind("AI"),
	-- },
      },
    },
  },
  opts_extend = { "sources.default" }
}
