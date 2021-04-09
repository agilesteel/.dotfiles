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
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#ffffff' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

highlight GitGutterAdd    guifg=#95B47B ctermfg=107
highlight GitGutterChange guifg=#B294BB ctermfg=13
highlight GitGutterDelete guifg=#CC6666 ctermfg=9
