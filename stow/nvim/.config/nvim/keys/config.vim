" Bind Ctrl+S to save the file in any more.
 noremap <silent> <C-S>      :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" Change the ESC key to jk or kj
inoremap jk <ESC>
inoremap kj <ESC>

" Map leader to space instead of ESC
let mapleader = " "
