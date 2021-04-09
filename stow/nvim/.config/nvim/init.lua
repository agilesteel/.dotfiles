vim.cmd('source ~/.config/nvim/init-old.vim')
require('plugins')
require('settings/keys')
require('settings/telescope')

-- map("n", "<C-p>", [[<cmd>lua require"telescope.builtin".find_files()<CR>]])
-- map("n", "<leader>fg", [[<cmd>lua require"telescope.builtin".live_grep()<CR>]])
-- map("n", "<M-p>", [[<cmd>lua require"telescope.builtin".buffers()<CR>]])
