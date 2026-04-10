-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  enabled = vim.g.vscode == nil,
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup {}
  end,
}
