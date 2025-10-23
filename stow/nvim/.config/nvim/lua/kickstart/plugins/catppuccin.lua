-- Catppuccin colorscheme with custom highlights
return {
  {
    'catppuccin/nvim',
    enabled = vim.g.vscode == nil,
    name = 'catppuccin',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin-frappe'

      vim.cmd 'highlight QuickScopePrimary gui=underline cterm=underline'
      vim.cmd 'highlight QuickScopeSecondary gui=nocombine cterm=nocombine'
      vim.cmd 'highlight Comment ctermbg=NONE ctermfg=167 guibg=NONE guifg=#ff5252 cterm=NONE gui=NONE'
      vim.cmd 'highlight TreesitterContext guibg=#292c3c'
      vim.cmd 'highlight TreesitterContextLineNumber guibg=#292c3c'
      vim.cmd 'highlight TreesitterContextBottom gui=NONE'
      vim.cmd 'highlight TreesitterContextLineNumberBottom gui=NONE'
      vim.cmd 'highlight FloatBorder guifg=#626880'
      vim.cmd 'highlight DiagnosticUnderlineInfo gui=nocombine cterm=nocombine'
      vim.cmd 'highlight DiagnosticUnderlineWarn gui=nocombine cterm=nocombine'
      vim.cmd 'highlight DiagnosticUnderlineError gui=nocombine cterm=nocombine'

      vim.api.nvim_set_hl(0, '@keyword', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@keyword.conditional', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@keyword.function', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@keyword.import', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@keyword.modifier', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@keyword.operator', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@keyword.type', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@lsp.type.keyword', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@lsp.type.modifier', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@operator', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = '#e78284' })
      vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = '#e78284' })

      vim.api.nvim_set_hl(0, '@module', { fg = '#efc176' })
      vim.api.nvim_set_hl(0, '@lsp.type.namespace', { fg = '#efc176' })

      vim.api.nvim_set_hl(0, '@lsp.type.variable', { fg = 'Red' })
      vim.api.nvim_set_hl(0, '@lsp.type.interface', { fg = '#e5c890' })
      vim.api.nvim_set_hl(0, '@lsp.type.typeParameter', { fg = '#fcc5aa' })

      vim.api.nvim_set_hl(0, '@lsp.mod.readonly', { fg = '#babbf1' })
      vim.api.nvim_set_hl(0, '@variable.parameter', { fg = '#babbf1' })
    end,
    opts = {
      term_colors = true,
      transparent_background = true,
      float = {
        transparent = true,
        solid = false,
      },
      dim_inactive = {
        enabled = false,
        shade = 'dark',
        percentage = 0.15,
      },
      no_italic = true,
      no_bold = true,
      integrations = {
        notify = true,
        fidget = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
      },
    },
  },
}
