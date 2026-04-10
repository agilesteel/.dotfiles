-- Autoformat
return {
  {
    'stevearc/conform.nvim',
    enabled = vim.g.vscode == nil,
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_format = not disable_filetypes[vim.bo[bufnr].filetype] and 'fallback' or 'never',
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },
}
