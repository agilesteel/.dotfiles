-- UI enhancements and visual plugins
return {
  {
    'lukas-reineke/virt-column.nvim',
    enabled = vim.g.vscode == nil,
    opts = {
      char = '│',
      virtcolumn = '100',
      highlight = 'LineNr',
    },
  },
  {
    'Bekaboo/dropbar.nvim',
    enabled = vim.g.vscode == nil,
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
    },
  },
  {
    'folke/snacks.nvim',
    enabled = vim.g.vscode == nil,
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  {
    'folke/trouble.nvim',
    enabled = vim.g.vscode == nil,
    opts = {
      warn_no_results = false,
    },
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    enabled = vim.g.vscode == nil,
    opts = {
      highlight_whole_line = false,
    },
    init = function()
      vim.wo.signcolumn = 'yes'
      vim.diagnostic.config {
        virtual_text = false,
        virtual_lines = { highlight_whole_line = false },
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = vim.g.vscode == nil,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  {
    'norcalli/nvim-colorizer.lua',
    enabled = vim.g.vscode == nil,
    opts = {},
    config = function()
      require('colorizer').setup()
    end,
  },
}
