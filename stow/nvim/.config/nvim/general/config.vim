syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open
" set nowrap                              " Display long lines as just one line
set linebreak                           " Don't break words in half
set encoding=utf-8                      " The encoding displayed
" set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
" set cmdheight=2                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
" set laststatus=0                        " Always display the status line
" set number                              " Line numbers
" set relativenumber                      " Relative line numbers
set cursorline                          " Enable highlighting of the current line
" set cursorcolumn                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=200                      " By default timeoutlen is 1000 ms
" set clipboard=unnamedplus               " Copy paste between vim and everything else
" set autochdir                           " Your working directory will always be the same as your working directory

autocmd BufNewFile,BufRead * setlocal formatoptions-=cro " stop newline continution of comments
autocmd BufWritePre * %s/\s\+$//e       " Remove trailing whitespaces on save.
" au! BufWritePost $MYVIMRC source %      " Auto source when writing to init.vm alternatively you can run :source $MYVIMRC
au BufRead,BufNewFile *.sbt set filetype=scala " Configuration for vim-scala

autocmd BufWritePre *.scala lua vim.lsp.buf.formatting_sync(nil, 1000)

:set number

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" You can't stop me
" cmap w!! w !sudo tee %

" Configure vim:
set spelllang=en " Set spell check language to English.
set spellfile=~/.config/nvim/en.utf-8.add " Add custom English dictionary.
set autoread

" Basics
filetype plugin indent on
" set list listchars=tab:»\ ,trail:·
