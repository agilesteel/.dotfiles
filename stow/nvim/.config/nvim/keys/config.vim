" Bind Ctrl+S to save the file in any more.
 noremap <silent> <C-S>      :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" NERDCommenter
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" Change the ESC key to jk or kj
inoremap jk <ESC>
inoremap kj <ESC>

" fzf
noremap <C-p> :Files<CR>
noremap <C-w> :bd<CR> " close/delete buffer
noremap <M-p> :Buffers<CR>
