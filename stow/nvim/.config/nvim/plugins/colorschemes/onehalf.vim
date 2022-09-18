autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
autocmd ColorScheme * highlight LineNr ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
autocmd ColorScheme * highlight Comment ctermbg=NONE ctermfg=167 guibg=NONE guifg=#ff5252 cterm=NONE gui=NONE
" autocmd ColorScheme * highlight Terminal ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
" autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
" autocmd ColorScheme * highlight StatusLine ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
" autocmd ColorScheme * highlight StatusLineTerm ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
" autocmd ColorScheme * highlight StatusLineNC ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
" autocmd ColorScheme * highlight StatusLineTermNC ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
" autocmd ColorScheme * highlight Pmenu ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
" autocmd ColorScheme * highlight TabLine ctermbg=NONE guibg=NONE cterm=NONE gui=NONE

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary gui=underline cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary gui=nocombine cterm=nocombine
augroup END

autocmd ColorScheme * highlight GitGutterAdd    ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight GitGutterChange ctermbg=NONE guibg=NONE
autocmd ColorScheme * highlight GitGutterDelete ctermbg=NONE guibg=NONE
