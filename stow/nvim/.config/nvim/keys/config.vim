" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Use alt + hjkl to resize windows
nnoremap <silent> <M-j> :resize +2<CR>
nnoremap <silent> <M-k> :resize -2<CR>
nnoremap <silent> <M-h> :vertical resize -2<CR>
nnoremap <silent> <M-l> :vertical resize +2<CR>

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>

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

" fzf
noremap <silent> <C-p> :Files<CR>
noremap <silent> <M-p> :Buffers<CR>

" misc
noremap <silent> <C-w> :bd<CR> " close/delete buffer
noremap <silent> <Esc> :noh<CR> " removes highlighting after escape is pressed

" soft wrap motions
" they colide with split moves
" vmap <C-j> gj
" vmap <C-k> gk
" vmap <C-4> g$
" vmap <C-6> g^
" vmap <C-0> g^
" nmap <C-j> gj
" nmap <C-k> gk
" nmap <C-4> g$
" nmap <C-6> g^
" nmap <C-0> g^
