-- Comment toggling
return {
  {
    'numToStr/Comment.nvim',
    enabled = vim.g.vscode == nil,
    opts = {
      toggler = {
        line = '<C-_>',
        block = '<C-S-_>',
      },
      opleader = {
        line = '<C-_>',
        block = '<C-S-_>',
      },
    },
  },
}
