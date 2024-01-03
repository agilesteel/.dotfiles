alias aliases='bat ~/.bash_aliases --pager never && bat ~/.local/.bash_aliases --pager never 2>/dev/null'

# for mac
alias l='ls -lah --color=auto'
alias ll='ls -lh --color=auto'

alias asl='aws sso login'
alias b='bloop'
alias bcb='bat cache --build'
alias br='bloop exit && bloop about'
alias c='code .'
alias ce='code . && exit'
alias dg-with-tests='bloop projects --dot-graph | dot -Tsvg -o dependency-graph.svg'
alias dg='bloop projects --dot-graph | sed "/-test/d" | dot -Tsvg -o dependency-graph.svg'
alias di='echo dotenv >> .envrc && touch .env && direnv allow'
alias din='echo "use nix" > .envrc && echo "watch_file nix/*" >> .envrc && di'
alias dots='cd ~/.dotfiles'
alias dr='direnv reload'
alias gunwip='git log -n 1 | grep -q -c "\--wip--" && git reset HEAD~1'
alias hydrate='gfa && gcd && gl && gbdanr'
alias ipp='curl ifconfig.me && echo'
alias jps='jps -lm'
alias jpsk9='jps | fzf --reverse -m -e -i | cut -d " " -f1 | xargs kill -9 2>/dev/null'
alias jpsk='jps | fzf --reverse -m -e -i | cut -d " " -f1 | xargs kill 2>/dev/null'
alias k='kubectl'
alias ld='lazydocker'
alias list-colors='for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\''\n'\''}; done'
alias new-install-repo='g8 git@github.com:agilesteel/install-seed.g8.git'
alias sbtd='sbt -jvm-debug 5005'
alias sbtk='(echo 1000 > /proc/self/oom_score_adj && exec sbt)'
alias sbtnoss='sbt -Dsbt.supershell=false'
alias scalac-phases='scalac -Xshow-phases'
alias scalalines='find . -path "*/src*" -name "*.scala" | xargs wc -l | sort -n'
alias vimc='vim ~/.config/nvim/general/config.vim'
alias vimi='vim ~/.config/nvim/init.vim'
alias vimp='vim ~/.config/nvim/plugins/all.vim'

alias update='\
  sudo apt update && \
  sudo apt -y full-upgrade && \
  sudo apt -y autoremove && \
  cs update && \
  refresh-completions && \
  nix-channel --update && \
  nix-env -u && \
  cd ~/.dotfiles && \
  gl && \
  nix flake update --flake ~/.dotfiles/nix/home-manager && \
  hms && \
  nvim --headless +PackerSync +PlugUpdate +qall'

alias updates='\
  sudo apt update && \
  sudo apt -y full-upgrade && \
  sudo apt -y autoremove && \
  cs update && \
  refresh-completions && \
  nix-channel --update && \
  nix-env -u && \
  cd ~/.dotfiles && \
  gl && \
  hms && \
  nvim --headless +PackerSync +PlugUpdate +qall'

# Nix
alias nfu='nix flake update'

# Nix Home Manager
alias hm='home-manager'
alias hmd='cd ~/.dotfiles/nix/home-manager'
alias hmgd='home-manager generations | head -n 2 | tac | cut -d " " -f 7 | xargs nix store diff-closures'
alias hmp='home-manager packages'
alias hms='home-manager switch --flake ~/.dotfiles/nix/home-manager#vlad && hmgd'
alias hmu='nix flake update ~/.dotfiles/nix/home-manager && hms'
alias hmhe='nvim ~/.dotfiles/nix/home-manager/home.nix'

# Git and GitHub
alias fgco='gco $(gb | fzf)'
alias fgcor='gco --track $(gbr | fzf)'
alias fgcot='gco $(g tag | fzf)'
alias gapaa='gaa -N && gapa .'
alias gbdanr='git branch -D $(git for-each-ref --format="%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)" refs/heads) 2>/dev/null'
alias gbda!='git branch --no-color | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch -D 2>/dev/null'
alias gca!='gaa && g commit --amend'
alias gcaf='gaa && g commit --fixup --no-verify'
alias gcam='gaa && gcmsg'
alias gcamr='gcam "chore: refactoring"'
alias gcan!='gaa && g commit --amend --no-edit --no-verify'
alias gcangpf!='gcan! && gpf!'
alias gcas='gaa && g commit --squash --no-verify'
alias ghdi='gi && gh rcd && gpsup && gh rvw'
alias ghdim='gim && gh rcd && gpsup && gh rvw'
alias ghdip='gi && gh rcdp && gpsup && gh rvw'
alias ghi='gi && gh rc && gpsup && gh rvw'
alias ghim='gim && gh rc && gpsup && gh rvw'
alias ghip='gi && gh rcp && gpsup && gh rvw'
alias gi='g init && gcam "Initial commit"'
alias gim='g init -b master && gcam "Initial commit"'
alias gitalias='alias | grep git | fzf'
alias glol='g log --graph --pretty='\''%C(yellow)%h%Creset%C(auto)%d%Creset %s %Cgreen%cr %C(bold blue)%an%Creset'\'''
alias glola='glol --all'
alias gpe='gp && exit'
alias grbio='grbi @{u}'
alias grbiod='grbi origin/$(git_develop_branch)'
alias grbod='grb origin/$(git_develop_branch)'
alias grhod='grh origin/$(git_develop_branch)'
alias grbiom='grbi origin/$(git_main_branch)'
alias grbom='grb origin/$(git_main_branch)'
alias grhom='grh origin/$(git_main_branch)'
alias groh='grh @{u}'
alias grohh='grhh @{u}'
alias gs='git -c delta.side-by-side=true'
alias gsd='gs diff'
alias gsds='gs diff --staged'
alias gstfu='g commit --amend && grbc'
alias gwipe='gwip && exit'
alias gwipgp='gwip && gp'
alias gwipgpe='gwip && gpe'
alias gwipp='gcmsg "--wip-- [skip ci]" --no-verify --no-gpg-sign'
alias hk='gcam housekeeping && gpe'
alias lg='lazygit'

# Nix
alias nix-shell-q='echo -e ${buildInputs// /\\n} | cut -d - -f 2- | sort' # like nix-env -q
alias nix-shell-qq='echo -e ${buildInputs// /\\n} | sort -t- -k2,2 -k3,3' # like nix-env -q

# Kickstart
alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
