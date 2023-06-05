if [ -f "$HOME/.zshrc" ] ; then
  source "$HOME/.zshrc"
fi

if [ -f "$HOME/.local/.zprofile" ] ; then
  source "$HOME/.local/.zprofile"
fi
