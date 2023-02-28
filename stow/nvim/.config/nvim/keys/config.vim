" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Use alt + hjkl to resize windows
nnoremap <silent> <M-j> :resize +2<CR>
nnoremap <silent> <M-k> :resize -2<CR>
nnoremap <silent> <M-h> :vertical resize -2<CR>
nnoremap <silent> <M-l> :vertical resize +2<CR>

inoremap jk <Esc>

" Switching buffers
nnoremap <silent> <C-PageDown> :bnext<CR>
nnoremap <silent> <C-PageUp> :bprevious<CR>

" Alternate way to save
 noremap <silent> <C-S>      :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>gv
inoremap <silent> <C-S> <C-O>:update<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
nnoremap <C-c> <Esc>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da

" NERDCommenter
nmap <silent> <C-_> <Plug>NERDCommenterToggle
vmap <silent> <C-_> <Plug>NERDCommenterToggle<CR>gv

" Telescope
nnoremap <C-p> <cmd>Telescope find_files<CR>
nnoremap <M-p> <cmd>Telescope buffers<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>vrc :lua require('settings.telescope').search_dotfiles()<CR>

" misc
nnoremap <silent> <C-w> :bd<CR>
nnoremap <silent> <Esc> :noh<CR>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" macros
if exists('g:vscode')
  nnoremap z= <Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>
  call setreg('p', "f.s\<CR>package \<Esc><Cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<CR>", 'linewise')
else
  call setreg('p', "f.s\<CR>package \<Esc>", 'linewise')
endif
