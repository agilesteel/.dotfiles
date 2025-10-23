-- MCP Hub integration
return {
  {
    'ravitemer/mcphub.nvim',
    enabled = vim.g.vscode == nil,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'npm install -g mcp-hub@latest',
    config = function()
      require('mcphub').setup()
    end,
  },
}
