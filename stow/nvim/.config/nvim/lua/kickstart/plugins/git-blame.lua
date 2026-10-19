-- Inline git blame for the current line (via gitsigns, which also handles
-- worktrees that live outside the main repo, e.g. ~/.herdr/worktrees)
return {
  'lewis6991/gitsigns.nvim',
  enabled = vim.g.vscode == nil,
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signcolumn = false,
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 100,
    },
    current_line_blame_formatter = '<author> | <author_time:%R> | <summary>',
  },
  config = function(_, opts)
    require('gitsigns').setup(opts)
    vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { link = 'LineNr' })
  end,
}
