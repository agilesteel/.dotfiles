# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes bloop if it exists
if [ -d "$HOME/.bloop" ] ; then
    PATH="$HOME/.bloop:$PATH"
fi

export GRAALVM_HOME=/usr/lib/jvm/graalvm/bin

# set PATH so it includes GRAALVM_HOME if it exists
if [ -d "$GRAALVM_HOME" ] ; then
    PATH="$PATH:$GRAALVM_HOME"
fi

export VISUAL="/usr/bin/vim"
export EDITOR="/usr/bin/vim"

# source local settings
if [ -f "$HOME/.local/.profile" ] ; then
    source "$HOME/.local/.profile"
fi
