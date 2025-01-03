local defaults = {
  editor = {
    git = {
      blame = {
        enabled = true,
        message = "<author>, <author_time:%R> - <summary>",
        delay = 0,
      },
    },
    lsp = {
      enableInlayHints = true,
    },
  },
  keymaps = {
    fileExplorer = {
      open = "<leader>fe",
    },
    editor = {
      toggleCommentLinewise = "<C-_>",
      openDocumentDiagnostics = "<leader>dd",
      toggleTodoComments = "<leader>tt",
      toggleTodoFixComments = "<leader>ttf",
      autoComplete = {
        open = "<C-Space>",
        close = "<C-e>",
        select = "<CR>",
      },
      test = {
        runNearest = "<leader>tn",
        runFile = "<leader>tf",
        openOutput = "<leader>to",
        openSummary = "<leader>ts",
        runDebug = "<leader>tdbg",
      },
    },
    search = {
      inFiles = "<leader>/",
      files = "<leader>ff",
      buffers = "<leader>fb",
      gitBranches = "<leader>gb",
      gitCommits = "<leader>gc",
      gitStatus = "<leader>gs",
      commandHistory = "<leader>sh",
      helpTags = "<leader>sH",
      keymaps = "<leader>sk",
      todoComments = "<leader>st",
    },
  },
  ui = {
    border = "rounded",
    colorscheme = "tokyonight-night",
    indentationGuide = true,
  },
  -- icons used by other plugins
  -- stylua: ignore
  icons = {
    misc = {
      dots = "󰇘",
    },
    ft = {
      octo = "",
    },
    debug = {
      Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint          = " ",
      BreakpointCondition = " ",
      BreakpointRejected  = { " ", "DiagnosticError" },
      LogPoint            = ".>",
    },
    diagnostics = {
      Error = " ",
      Warn  = " ",
      Hint  = " ",
      Info  = " ",
    },
    git = {
      added    = " ",
      modified = " ",
      removed  = " ",
    },
    kinds = {
      AI            = "󰚩 ",
      Array         = " ",
      Boolean       = "󰨙 ",
      Class         = " ",
      Codeium       = "󰘦 ",
      Color         = " ",
      Control       = " ",
      Collapsed     = " ",
      Constant      = "󰏿 ",
      Constructor   = " ",
      Copilot       = " ",
      Enum          = " ",
      EnumMember    = " ",
      Event         = " ",
      Field         = " ",
      File          = " ",
      Folder        = " ",
      Function      = "󰊕 ",
      Interface     = " ",
      Key           = " ",
      Keyword       = " ",
      Method        = "󰊕 ",
      Module        = " ",
      Namespace     = "󰦮 ",
      Null          = " ",
      Number        = "󰎠 ",
      Object        = " ",
      Operator      = " ",
      Package       = " ",
      Property      = " ",
      Reference     = " ",
      Snippet       = " ",
      String        = " ",
      Struct        = "󰆼 ",
      TabNine       = "󰏚 ",
      Text          = " ",
      TypeParameter = " ",
      Unit          = " ",
      Value         = " ",
      Variable      = "󰀫 ",
    },
  },
}

return defaults
