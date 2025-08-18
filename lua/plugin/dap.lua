return {
  'mfussenegger/nvim-dap',
  tag = '0.10.0',
  dependencies = {
    'rcarriga/nvim-dap-ui',
  },
  keys = {
    { '<leader>db', '<cmd>DapToggleBreakpoint<cr>', desc = 'Toggle Breakpoint' },
    { '<leader>dh', '<cmd>DapUIWidgetsHover<cr>', desc = 'Debug Hover' },
  },
  config = function()
    local dap = require('dap')

    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'js-debug-adapter',
        args = { '${port}' },
      },
    }

    dap.configurations.typescript = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
    }
  end
}
