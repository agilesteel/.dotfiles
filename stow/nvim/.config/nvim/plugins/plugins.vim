" install the vim-plug plugin manager.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

" Install plugins:
call plug#begin('~/.local/share/nvim/plugged')
source ~/.config/nvim/plugins/list.vim
call plug#end()
