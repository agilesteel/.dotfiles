return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    enabled = vim.g.vscode == nil,
    main = 'ibl',
    opts = {
      scope = {
        show_start = false,
        show_end = false,
        injected_languages = true,
        char = '│',
        -- highlight = { 'WinBar' },
        highlight = { 'LineNr' },
        include = {
          -- node_type = { ['*'] = { '*' } },
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
        char = ' ',
      },
    },
  },
}
