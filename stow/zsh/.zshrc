# source local settings
if [ -f "$HOME/.zshrc4mac" ] ; then
  source "$HOME/.zshrc4mac"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=1

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  extract
  git
  mosh
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-z
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Setup a custom completions directory
fpath=($HOME/.local/share/zsh/completions $fpath)

# Enable the completion system
autoload compinit

# Initialize all completions on $fpath and ignore (-i) all insecure files and directories
compinit -i

# Refresh completions
function refresh-completions() {
  local DIR=$HOME/.local/share/zsh/completions

  # bloop
  curl -s https://raw.githubusercontent.com/scalacenter/bloop/master/etc/zsh-completions -o $DIR/_bloop

  # cs
  # cs --completions zsh > $DIR/_cs
  # cs --completions zsh > $DIR/_coursier

  # sed -i 's/#compdef cs/#compdef coursier/' $DIR/_coursier

  # gh
  gh completion -s zsh > $DIR/_gh

  # scalafix
  # scalafix --zsh > $DIR/_scalafix

  # scalafmt
  curl -s https://raw.githubusercontent.com/scalameta/scalafmt/master/bin/_scalafmt -o $DIR/_scalafmt
}

# >>> scala-cli completions >>>
fpath=("$HOME/.local/share/scalacli/completions/zsh" $fpath)
compinit
# <<< scala-cli completions <<<

# ──────────────────────────────────────────────────

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
  . $HOME/.nix-profile/etc/profile.d/nix.sh;
fi # added by Nix installer

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi

# set PATH so it includes coursier bin if it exists
if [ -d "$HOME/.local/share/coursier/bin" ] ; then
  PATH="$PATH:$HOME/.local/share/coursier/bin"
fi

if [ -d "$HOME/Library/Application Support/Coursier/bin" ] ; then
  PATH="$PATH:$HOME/Library/Application Support/Coursier/bin"
fi

if [ -e $HOME/.nix-profile/bin/java ]; then
  export JAVA_HOME="${$(readlink -e $HOME/.nix-profile/bin/java)%*/bin/java}" 2>/dev/null
fi

export JAVA_TOOL_OPTIONS="
-Dconfig.override_with_env_vars=true
-Djava.net.preferIPv4Stack=true
-Duser.timezone=UTC
"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

# MANPAGER
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

export LANG="C.UTF-8"

if [[ $(command -v keychain) && -e ~/.ssh/id_rsa ]]; then
  eval `keychain --eval --quiet id_rsa`
fi

if [[ $(command -v keychain) && -e ~/.ssh/id_ed25519 ]]; then
  eval `keychain --eval --quiet id_ed25519`
fi

if [ $(command -v direnv) ]; then
  export DIRENV_LOG_FORMAT=
  eval "$(direnv hook zsh)"
fi

# starship
if [ $(command -v starship) ]; then
  eval "$(starship init zsh)"
fi

# aliases
alias v="vim"

if [ $(command -v nvim) ]; then
  export EDITOR=$(which nvim)
  alias vim=$EDITOR
  alias v=$EDITOR
fi

export SUDO_EDITOR=$EDITOR
export VISUAL=$EDITOR

# stow (th stands for target=home)
stowth() {
  stow -vSt ~ $1
}

unstowth() {
  stow -vDt ~ $1
}

diy-install() {
  wget -q https://script.install.devinsideyou.com/$1
  sudo chmod +x $1 && ./$1 $2 $3
}

up_widget() {
  BUFFER="cd .."
  zle accept-line
}

zle -N up_widget
bindkey "^\\" up_widget

which-gc() {
  jcmd $1 VM.info | grep -ohE "[^\s^,]+\sgc"
}

docker-armageddon() {
  docker stop $(docker ps -aq) # stop containers
  docker rm $(docker ps -aq) # rm containers
  docker network prune -f # rm networks
  docker rmi -f $(docker images --filter dangling=true -qa) # rm dangling images
  docker volume rm $(docker volume ls --filter dangling=true -q) # rm volumes
  docker rmi -f $(docker images -qa) # rm all images
}

# source global settings
if [ -f "$HOME/.bash_aliases" ] ; then
  source "$HOME/.bash_aliases"
fi

if [ $(command -v fzf) ]; then
  # Set up fzf key bindings and fuzzy completion
  eval "$(fzf --zsh)"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "$HOME/.p10k.zsh" ]] || source "$HOME/.p10k.zsh"

# source local settings
if [ -f "$HOME/.local/.zshrc" ] ; then
  source "$HOME/.local/.zshrc"
fi

if [ -f "$HOME/.local/.bash_aliases" ] ; then
  source "$HOME/.local/.bash_aliases"
fi
