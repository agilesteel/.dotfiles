-- Highlight, edit, and navigate code
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup {}

      -- Install parsers asynchronously (skips already-installed ones)
      require('nvim-treesitter').install {
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
      }

      -- Enable treesitter highlighting for all buffers with an installed parser
      -- (replaces the old `highlight = { enable = true }` from the master branch)
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
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
