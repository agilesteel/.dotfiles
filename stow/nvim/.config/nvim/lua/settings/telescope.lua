require('telescope').load_extension('fzy_native')

require('telescope').setup({

})

local M = {}

-- This is mainly for Metals since we don't respond to "" as a query to get all
-- the symbols. This will first get the input form the user and then execute
-- the query.
M.lsp_workspace_symbols = function()
  local input = vim.fn.input("Query: ")
  vim.api.nvim_command("normal :esc<CR>")
  if not input or #input == 0 then
    return
  end
  require("telescope.builtin").lsp_workspace_symbols({ query = input })
end

M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< VimRC >",
    cwd = "~/.dotfiles/stow/nvim"
  })
end

return M
