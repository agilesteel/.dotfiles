"Enable line numbers relative to current line while replacing 0 with current line number.
:set number relativenumber

"Use 2 spaces instead of tabs.
:set shiftwidth=2 tabstop=2 expandtab

"Set spell check language to English.
:set spelllang=en

"Add custom English dictionary.
:set spellfile=~/.config/nvim/en.utf-8.add

"Bind Ctrl+S to save the file in any more. 
 noremap <silent> <C-S>      :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

"Install the vim-plug plugin manager.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim 
endif

"Install plugins:
call plug#begin('~/.local/share/nvim/plugged')

call plug#end()
