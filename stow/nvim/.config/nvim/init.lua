vim.cmd('source ~/.config/nvim/init-old.vim')

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local f = require("settings.functions")
local map = f.map
local opt = f.opt

require('plugins')
require('settings.keys')
require('settings.telescope')
require('settings.catppuccin').setup()

require("nvim-tree").setup()
require("settings.functions")
require("settings.compe").setup()
-- require("settings.telescope").setup()
require("settings.lsp").setup()

require("settings.galaxyline").setup()
-- require("nvim-autopairs").setup()

require("nvim-treesitter.configs").setup({
  -- playground = { enable = true },
  -- query_linter = {
  -- enable = true,
  -- use_virtual_text = true,
  -- lint_events = { "BufWrite", "CursorHold" },
  -- },
  -- ensure_installed = "maintained",
  -- highlight = { enable = true },
})

-- require("lspsaga").init_lsp_saga({
--   server_filetype_map = { metals = { "sbt", "scala" } },
--   code_action_prompt = { virtual_text = false },
-- })

g["mapleader"] = " "
g["netrw_gx"] = "<cWORD>"
-- g["indentLine_char"] = "┊"
-- g["indentLine_setColors"] = 0

g["nvim_tree_indent_markers"] = 1
g["nvim_tree_group_empty"] = 1
-- g["nvim_tree_lsp_diagnostics"] = 1

g["vim_markdown_conceal"] = 0
g["vim_markdown_conceal_code_blocks"] = 0

local indent = 2
vim.o.shortmess = string.gsub(vim.o.shortmess, "F", "") .. "c"
vim.o.path = vim.o.path .. "**"

-- -- global
-- opt("o", "termguicolors", true)
opt("o", "hidden", true)
-- opt("o", "showtabline", 1)
-- opt("o", "updatetime", 300)
opt("o", "showmatch", true)
-- opt("o", "laststatus", 2)
opt("o", "wildignore", ".git,*/node_modules/*,*/target/*,.metals,.bloop")
-- opt("o", "ignorecase", true)
opt("o", "smartcase", true)
-- opt("o", "clipboard", "unnamed")
opt("o", "completeopt", "menu,menuone,noselect")

-- -- window-scoped
-- opt("w", "wrap", false)
-- opt("w", "cursorline", true)
opt("w", "signcolumn", "yes")

-- -- buffer-scoped
-- opt("b", "tabstop", indent)
-- opt("b", "shiftwidth", indent)
-- opt("b", "softtabstop", indent)
-- opt("b", "expandtab", true)
-- opt("b", "fileformat", "unix")

-- normal-mode mappings
map("n", "<leader>hs", ":nohlsearch<cr>")
map("n", "<leader>xml", ":%!xmllint --format -<cr>")
map("n", "<leader>fo", ":copen<cr>")
map("n", "<leader>fc", ":cclose<cr>")
map("n", "<leader>fn", ":cnext<cr>")
map("n", "<leader>fp", ":cprevious<cr>")
map("n", "<leader>tv", ":vnew | :te<cr>")

-- LSP
map("n", "gd", [[<cmd>lua vim.lsp.buf.definition()<CR>]])
-- map("n", "K", [[<cmd>lua require"lspsaga.hover".render_hover_doc()<CR>]])
map("n", "gi", [[<cmd>lua vim.lsp.buf.implementation()<CR>]])
map("n", "gr", [[<cmd>lua vim.lsp.buf.references()<CR>]])
map("n", "<leader>ccl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
map("n", "gds", [[<cmd>lua require"telescope.builtin".lsp_document_symbols()<CR>]])
map("n", "gws", [[<cmd>lua require"settings.telescope".lsp_workspace_symbols()<CR>]])
-- map("n", "<leader>rn", [[<cmd>lua require"lspsaga.rename".rename()<CR>]])
-- map("n", "<leader>ca", [[<cmd>lua require"lspsaga.codeaction".code_action()<CR>]])
-- map("v", "<leader>ca", [[<cmd>lua require"lspsaga.codeaction".range_code_action()<CR>]])
map("n", "<leader>ws", [[<cmd>lua require"metals".worksheet_hover()<CR>]])
map("n", "<leader>a", [[<cmd>lua require"metals".open_all_diagnostics()<CR>]])
map("n", "<leader>d", [[<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>]]) -- buffer diagnostics only
-- map("n", "]c", [[<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<CR>]])
-- map("n", "[c", [[<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>]])
map("n", "<leader>ln", [[<cmd>lua vim.lsp.diagnostic.get_line_diagnostics()<CR>]])

-- completion
map("i", "<S-Tab>", [[pumvisible() ? "<C-p>" : "<Tab>"]], { expr = true })
map("i", "<Tab>", [[pumvisible() ? "<C-n>" : "<Tab>"]], { expr = true })
map("i", "<CR>", [[compe#confirm("<CR>")]], { expr = true })

-- telescope
map("n", "<leader>ff", [[<cmd>lua require"telescope.builtin".find_files()<CR>]])
map("n", "<C-p>", [[<cmd>lua require"telescope.builtin".find_files()<CR>]])
map("n", "<M-p>", [[<cmd>lua require"telescope.builtin".buffers()<CR>]])
map("n", "<leader>lg", [[<cmd>lua require"telescope.builtin".live_grep()<CR>]])

-- nvim-dap
map("n", "<leader>dc", [[<cmd>lua require"dap".continue()<CR>]])
map("n", "<leader>dr", [[<cmd>lua require"dap".repl.toggle()<CR>]])
map("n", "<leader>dtb", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
map("n", "<leader>dso", [[<cmd>lua require"dap".step_over()<CR>]])
map("n", "<leader>dsi", [[<cmd>lua require"dap".step_into()<CR>]])

----------------------------------
-- COMMANDS ----------------------
----------------------------------
cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])
cmd([[autocmd FileType markdown setlocal textwidth=80]])
cmd([[autocmd BufEnter *.js call matchadd('ColorColumn', '\%81v', 100)]])
cmd(
  [[autocmd BufReadPost,BufNewFile *.md,*.txt,COMMIT_EDITMSG set wrap linebreak nolist spell spelllang=en_us complete+=kspell]])
cmd([[autocmd BufReadPost,BufNewFile .html,*.txt,*.md,*.adoc set spell spelllang=en_us]])
cmd([[autocmd TermOpen * startinsert]])

-- LSP
cmd([[augroup lsp]])
cmd([[autocmd!]])
cmd([[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
-- cmd([[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(Metals_config)]])
cmd([[augroup end]])

-- Needed to esnure float background doesn't get odd highlighting
-- https://github.com/joshdick/onedark.vim#onedarkset_highlight
-- cmd([[augroup colorset]])
-- cmd([[autocmd!]])
-- cmd([[autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" } })]])
-- cmd([[augroup END]])

----------------------------------
-- LSP Settings ------------------
----------------------------------
fn.sign_define("LspDiagnosticsSignError", { text = "•" })
fn.sign_define("LspDiagnosticsSignWarning", { text = "•" })
fn.sign_define("LspDiagnosticsSignInformation", { text = "•" })
fn.sign_define("LspDiagnosticsSignHint", { text = "•" })

vim.cmd([[hi! link LspReferenceText CursorColumn]])
vim.cmd([[hi! link LspReferenceRead CursorColumn]])
vim.cmd([[hi! link LspReferenceWrite CursorColumn]])

-- vim.cmd([[hi! link LspSagaFinderSelection CursorColumn]])
-- vim.cmd([[hi! link LspSagaDocTruncateLine LspSagaHoverBorder]])
