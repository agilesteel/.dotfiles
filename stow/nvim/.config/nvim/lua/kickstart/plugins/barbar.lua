-- Tab bar
return {
  {
    'romgrk/barbar.nvim',
    enabled = vim.g.vscode == nil,
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {},
    version = '^1.0.0',
  },
}
