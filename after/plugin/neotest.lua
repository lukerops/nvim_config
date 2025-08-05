require('neotest').setup({
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
})

vim.keymap.set('n', '<leader>tn', function()
  require('neotest').run.run()
end, { desc = 'Run the nearest test' })

vim.keymap.set('n', '<leader>tf', function()
  require('neotest').run.run({ vim.fn.expand('%') })
end, { desc = 'Run All Tests in the file' })

vim.keymap.set('n', '<leader>ts', function()
  require('neotest').summary.toggle()
end, { desc = 'Toggle the test summary' })

vim.keymap.set('n', '<leader>to', function()
  require('neotest').output.open({ enter = true })
end, { desc = 'Open the test output' })

vim.keymap.set('n', '<leader>td', function()
  require('neotest').run.run({ strategy = 'dap' })
end, { desc = 'Run the nearest test in debug' })

-- {"<leader>t", "", desc = "+test"},
-- { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
-- { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
-- { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
-- { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
-- { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
-- { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
-- { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
-- { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
-- { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
