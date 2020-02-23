set number relativenumber " Enable line numbers relative to current one while replacing 0 with current number.
set shiftwidth=2 tabstop=2 expandtab " Use 2 spaces instead of tabs.
set spelllang=en " Set spell check language to English.
set spellfile=~/.config/nvim/en.utf-8.add " Add custom English dictionary.
set mouse=a " Enable mouse support

" Bind Ctrl+S to save the file in any more.
 noremap <silent> <C-S>      :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Remove trailing whitespaces on save.
autocmd BufWritePre * %s/\s\+$//e

" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

" Install the vim-plug plugin manager.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

" Install plugins:
call plug#begin('~/.local/share/nvim/plugged')

Plug 'ajh17/Spacegray.vim' " Color scheme
Plug 'derekwyatt/vim-scala' " Scala
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Conquer of Completion
Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'} " Metals

call plug#end()

" Select colorscheme
colorscheme spacegray

" Color scheme settings
" Don't allow the color scheme to change background
au ColorScheme * hi Normal ctermbg=None
