if [ -f "$HOME/.zshrc" ] ; then
  source "$HOME/.zshrc"
fi

if [ -f "$HOME/.local/.zprofile" ] ; then
  source "$HOME/.local/.zprofile"
fi

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
