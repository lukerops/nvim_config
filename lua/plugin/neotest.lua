return {
  'nvim-neotest/neotest',
  tag = 'v5.9.1',
  dependencies = {
    { 'nvim-neotest/nvim-nio', tag = 'v1.10.1' },
    'nvim-neotest/neotest-jest',
  },
  keys = {
    { '<leader>tn', '<cmd>lua require("neotest").run.run()<cr>', desc = 'Run Nearest Test' },
    { '<leader>tf', '<cmd>lua require("neotest").run.run({ vim.fn.expand("%") })<cr>', desc = 'Run All Tests in File' },
    { '<leader>ts', '<cmd>lua require("neotest").summary.toggle()<cr>', desc = 'Toggle Test Summary' },
    { '<leader>to', '<cmd>lua require("neotest").output.open({ enter = true })<cr>', desc = 'Open Test Output' },
    { '<leader>td', '<cmd>lua require("neotest").run.run({ strategy = "dap" })<cr>', desc = 'Run Nearest Test in Debug' },
  },
  opts = function()
    return {
      icons = { running_animated = {"⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"} },
      floating = { border = 'rounded' },
      run = {
        augment = function(_, args)
          -- Add the environment variables from the .env file
          -- args.env = vim.tbl_deep_extend("force", args.env or {}, require("dotenv").get_envs())

          return args
        end,
      },
      adapters = {
        -- require("neotest-python")({
        --   args = { "-vv" },
        --   runner = "pytest",
        --   python = require("python").get_python_path(vim.loop.cwd()),
        -- }),
        require('neotest-jest')({
          jestCommand = "npm test --",
          -- jestConfigFile = "custom.jest.config.ts",
          -- env = { CI = true },
          -- cwd = function(path)
          --   return vim.fn.getcwd()
          -- end,
        }),
      }
    }
  end
}
