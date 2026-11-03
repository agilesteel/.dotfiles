# Interactive login shells read ~/.zshrc on their own right after this file,
# so only source it for non-interactive login shells (e.g. `zsh -lc ...`).
if [[ ! -o interactive && -f "$HOME/.zshrc" ]] ; then
  source "$HOME/.zshrc"
fi

if [ -f "$HOME/.local/.zprofile" ] ; then
  source "$HOME/.local/.zprofile"
fi

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
