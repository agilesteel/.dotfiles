-- Simple plugins with minimal or no configuration
return {
  { 'michaeljsmith/vim-indent-object' },
  { 'editorconfig/editorconfig-vim' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-unimpaired' },
  { 'unblevable/quick-scope' },
  { 'github/copilot.vim' },
  {
    'tveskag/nvim-blame-line',
    enabled = vim.g.vscode == nil,
  },
}
