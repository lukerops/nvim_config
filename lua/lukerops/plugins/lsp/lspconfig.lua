local config = require("lukerops.config")

return {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo", "LspInstall", "LspStart", },
  event = { "BufReadPre", "BufNewFile", },
  dependencies = {
    "saghen/blink.cmp",
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
      opts = {
        ensure_installed = { "lua_ls", "pylsp", "gopls", "terraformls" },
        handlers = {
          -- default handler
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,

          -- desativa a configuraço automática do tsserver
          -- para utilizar o typescript-tools
          ts_ls = function() end,
        }
      }
    },
  },
  config = function()
    local lspconfig = require('lspconfig')

    -- Add cmp_nvim_lsp capabilities settings to lspconfig
    lspconfig.util.default_config.capabilities = require('blink.cmp')
      .get_lsp_capabilities(lspconfig.util.default_config.capabilities)

    lspconfig.lsp_ai.setup({
      init_options = {
        -- memory = {
        --   -- It is important to use this method as `{}` will be interpreted as an array when it should be an object
        --   file_store = vim.fn.empty_dict()
        -- },
	models = {
	  ["qwen2.5-coder"] = {
	    type = "open_ai",
	    chat_endpoint = "https://chat.lukerops.com/ollama/v1/chat/completions",
	    model = "qwen2.5-coder:1.5b",
	    auth_token = os.getenv("OLLAMA_API_KEY"),
	  }
	  -- model1 = {
	  --   type = "ollama",
	  --   chat_endpoint = "http://192.168.15.212:11434/api/chat",
	  --   model = "qwen2.5-coder:1.5b",
	  -- }
        },
	completion = {
          model = "qwen2.5-coder",
          parameters = {
            -- max_context = 32768,
            -- max_tokens = 4096,
	    messages = {
	      {
	        role = "system",
	        content = "Instructions:\n- You are an AI programming assistant.\n- Given a piece of code with the cursor location marked by \"<CURSOR>\", replace \"<CURSOR>\" with the correct code or comment.\n- First, think step-by-step.\n- Describe your plan for what to build in pseudocode, written out in great detail.\n- Then output the code replacing the \"<CURSOR>\"\n- Ensure that your completion fits within the language context of the provided code snippet (e.g., Python, JavaScript, Rust).\n\nRules:\n- Only respond with code or comments.\n- Only replace \"<CURSOR>\"; do not include any previously written code.\n- Never include \"<CURSOR>\" in your response\n- If the cursor is within a comment, complete the comment meaningfully.\n- Handle ambiguous cases by providing the most contextually appropriate completion.\n- Be consistent with your responses."
	      },
	      {
	        role = "user",
	        content = "def greet(name):\n    print(f\"Hello, {<CURSOR>}\")"
	      },
	      {
	        role = "assistant",
	        content = "name"
	      },
	      {
	        role = "user",
	        content = "function sum(a, b) {\n    return a + <CURSOR>;\n}"
	      },
	      {
	        role = "assistant",
	        content = "b"
	      },
	      {
	        role = "user",
	        content = "fn multiply(a: i32, b: i32) -> i32 {\n    a * <CURSOR>\n}"
	      },
	      {
	        role = "assistant",
	        content = "b"
	      },
	      {
	        role = "user",
	        content = "# <CURSOR>\ndef add(a, b):\n    return a + b"
	      },
	      {
	        role = "assistant",
	        content = "Adds two numbers"
	      },
	      {
	        role = "user",
	        content = "# This function checks if a number is even\n<CURSOR>"
	      },
	      {
	        role = "assistant",
	        content = "def is_even(n):\n    return n % 2 == 0"
	      },
	      {
	        role = "user",
	        content = "{CODE}"
	      }
	    },
	    post_process = {
	      remove_duplicate_start = false,
	      remove_duplicate_end = false
	    }
          }
        }
      }
    })

    -- cria um on_attach default
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local id = vim.tbl_get(event, 'data', 'client_id')
        local client = vim.lsp.get_client_by_id(id) or {}

        local bufnr = event.buf
        local opts = { buffer = bufnr }

        -- ativa o inlay hint
        if config.editor.lsp.enableInlayHints and client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, opts)
        end

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        -- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>Trouble lsp_references<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      end,
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = config.ui.border,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = config.icons.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = config.icons.diagnostics.Warn,
          [vim.diagnostic.severity.HINT] = config.icons.diagnostics.Hint,
          [vim.diagnostic.severity.INFO] = config.icons.diagnostics.Info,
        }
      }
    })
  end,
}
