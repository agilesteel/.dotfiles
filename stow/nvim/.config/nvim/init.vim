" install the vim-plug plugin manager.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

" Install plugins:
call plug#begin('~/.local/share/nvim/plugged')
source ~/.config/nvim/plugins.vim
call plug#end()

" Configure plugins:
source ~/.config/nvim/plugins-init.vim

" Configure vim:
set number relativenumber " Enable line numbers relative to current one while replacing 0 with current number.
set shiftwidth=2 tabstop=2 expandtab " Use 2 spaces instead of tabs.
set spelllang=en " Set spell check language to English.
set spellfile=~/.config/nvim/en.utf-8.add " Add custom English dictionary.
set mouse=a " Enable mouse support

" Bind Ctrl+S to save the file in any more.
 noremap <silent> <C-S>      :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" Remove trailing whitespaces on save.
autocmd BufWritePre * %s/\s\+$//e

" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

" Color scheme settings (this lines needs to come before the colorscheme spacegray line)
" Don't allow the color scheme to change background
au ColorScheme * hi Normal ctermbg=None

" set termguicolors " this line overrides the previous line for some reason

" Select colorscheme
colorscheme spacegray

" Change the ESC key to jk
inoremap jk <ESC>

" Map leader to space instead of ESC
let mapleader = " "

" Basics
filetype plugin indent on
syntax on
set encoding=utf-8

" Use OS clipboard
set clipboard=unnamedplus
