return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      scope = {
        show_start = false,
        show_end = false,
        injected_languages = true,
        highlight = { 'WinBar' },
        -- highlight = { 'IndentBlanklineContextChar' },
        -- priority = 1024,
        include = {
          node_type = {
            ['*'] = {
              'arguments',
              'block',
              'bracket',
              'declaration',
              'expression_list',
              'field',
              'for',
              'func_literal',
              'function',
              'if',
              'import',
              'list',
              'return_statement',
              'short_var_declaration',
              'switch_body',
              'try',
              'type',
            },
          },
        },
      },
      indent = {
        char = '│',
      },
    },
  },
}
