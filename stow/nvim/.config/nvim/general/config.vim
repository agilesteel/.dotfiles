" Configure vim:
set number " Enable line numbers.
set shiftwidth=2 tabstop=2 expandtab " Use 2 spaces instead of tabs.
set spelllang=en " Set spell check language to English.
set spellfile=~/.config/nvim/en.utf-8.add " Add custom English dictionary.
set mouse=a " Enable mouse support
set autoread

" Remove trailing whitespaces on save.
autocmd BufWritePre * %s/\s\+$//e

" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

" set termguicolors " this line overrides the previous line for some reason

" Select colorscheme
colorscheme spacegray

" Basics
filetype plugin indent on
syntax on
set encoding=utf-8

" Use OS clipboard
set clipboard=unnamedplus
