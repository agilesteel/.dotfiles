alias aliases='bat ~/.bash_aliases --pager never && bat ~/.local/.bash_aliases --pager never 2>/dev/null'

# for mac
alias l='ls -lah --color=auto'
alias ll='ls -lh --color=auto'

# for eza
alias el='eza --long --binary --icons=always --sort=name --all --modified --git'
alias ell='eza --long --binary --icons=always --sort=name --modified --git'
alias ellr='eza --long --binary --icons=always --sort=modified --modified --git'

alias b='bloop'
alias br='bloop exit && bloop about'
alias c='code .'
alias ce='code . && exit'
alias dg-with-tests='bloop projects --dot-graph | dot -Tsvg -o dependency-graph.svg'
alias dg='bloop projects --dot-graph | sed "/-test/d" | dot -Tsvg -o dependency-graph.svg'
alias di='echo dotenv >> .envrc && touch .env && direnv allow'
alias dots='cd ~/.dotfiles'
alias dr='direnv reload'
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
alias vimi='vim ~/.config/nvim/init.lua'

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
  hms'

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
  hms'

# Git and GitHub
alias fgco='gco $(gb | fzf)'
alias fgcor='gco --track $(gbr | fzf)'
alias fgcot='gco $(g tag | fzf)'
alias gapaa='gaa -N && gapa .'
alias gbda!='git branch --no-color | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch -D 2>/dev/null'
alias gbdanr='git branch -D $(git for-each-ref --format="%(if:equals=[gone])%(upstream:track)%(then)%(refname:short)%(end)" refs/heads) 2>/dev/null'
alias gca!='gaa && g commit --amend'
alias gcaf='gaa && g commit --no-verify --fixup'
alias gcam='gaa && gcmsg'
alias gcan!='gaa && g commit --amend --no-edit --no-verify'
alias gcangpf!='gcan! && gpf!'
alias gcas='gaa && g commit --no-verify --squash'
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
alias grbiom='grbi origin/$(git_main_branch)'
alias grbod='grb origin/$(git_develop_branch)'
alias grbom='grb origin/$(git_main_branch)'
alias grhod='grh origin/$(git_develop_branch)'
alias grhom='grh origin/$(git_main_branch)'
alias groh='grh @{u}'
alias grohh='grhh @{u}'
alias gs='git -c delta.side-by-side=true'
alias gsd='gs diff'
alias gsds='gs diff --staged'
alias gstfu='g commit --amend && grbc'
alias gunwip='git log -n 1 | grep -q -c "\--wip--" && git reset HEAD~1'
alias gwipe='gwip && exit'
alias gwipgp='gwip && gp'
alias gwipgpe='gwip && gpe'
alias gwipp='gcmsg "--wip-- [skip ci]" --no-verify --no-gpg-sign'
alias hk='gcam housekeeping && gpe'
alias hydrate='gfa && (git fetch origin $(git_main_branch):$(git_main_branch) 2>/dev/null || gl) && (git fetch origin $(git_develop_branch):$(git_develop_branch) 2>/dev/null || gl) && gcd && gbdanr'
alias hydratem='gfa && (git fetch origin $(git_develop_branch):$(git_develop_branch) 2>/dev/null || gl) && (git fetch origin $(git_main_branch):$(git_main_branch) 2>/dev/null || gl) && gcm && gbdanr'
alias lg='lazygit'
alias nu='gcam "chore: nix flake update" && gpe'
alias refresh='gfa && grbom'
alias refreshd='gfa && grbod'
alias fl="cdg $HOME/dev/github/formslogic/fl"

# Nix
alias din='echo "use nix" > .envrc && echo "watch_file nix/*" >> .envrc && di'
alias nfu='nix flake update'
alias nix-shell-q='echo -e ${buildInputs// /\\n} | cut -d - -f 2- | sort' # like nix-env -q
alias nix-shell-qq='echo -e ${buildInputs// /\\n} | sort -t- -k2,2 -k3,3' # like nix-env -q

# Nix Home Manager
alias hm='home-manager'
alias hmd='cd ~/.dotfiles/nix/home-manager'
alias hmgd='home-manager generations | head -n 2 | tac | cut -d " " -f 7 | xargs nix store diff-closures 2>/dev/null || true'
alias hmp='home-manager packages'
alias hms='home-manager switch --flake ~/.dotfiles/nix/home-manager#vlad && hmgd'
alias hmu='nix flake update --flake ~/.dotfiles/nix/home-manager && hms'
alias hmhe='nvim ~/.dotfiles/nix/home-manager/home.nix'
