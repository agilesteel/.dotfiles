-- Highlight, edit, and navigate code
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'gitcommit',
        'git_rebase',
        'html',
        'just',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'scala',
        'vim',
        'vimdoc',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = vim.g.vscode == nil,
    opts = {
      max_lines = 10,
      multiline_threshold = 1,
      zindex = 1,
    },
  },
}
