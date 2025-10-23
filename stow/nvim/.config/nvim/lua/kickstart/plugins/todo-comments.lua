-- Highlight todo, notes, etc in comments
return {
  {
    'folke/todo-comments.nvim',
    enabled = vim.g.vscode == nil,
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
