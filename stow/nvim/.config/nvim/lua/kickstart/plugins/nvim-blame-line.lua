return {
  'tveskag/nvim-blame-line',
  enabled = vim.g.vscode == nil,
  event = { 'BufReadPre', 'BufNewFile' },
  init = function()
    -- Configure blame line settings before plugin loads
    vim.g.blameLineVirtualTextFormat = '%s'
    vim.g.blameLineUseVirtualText = 1
    vim.g.blameLineVirtualTextHighlight = 'LineNr'
    vim.g.blameLineGitFormat = '%an | %ar | %s'
  end,
  config = function()
    -- Enable blame line automatically when entering buffers
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = '*',
      callback = function()
        vim.cmd('EnableBlameLine')
      end,
    })
  end,
}
