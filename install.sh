#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first

# [ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Bunch of symlinks

ln -sfv "$DOTFILES_DIR/runcom/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore_global" ~
ln -sfv "$DOTFILES_DIR/tmux/tmux.conf" ~/.tmux.conf

if [ "$(uname)" == "Darwin" ]; then
	ln -sfv "$DOTFILES_DIR/pentadactyl/pentadactylrc" ~/.pentadactylrc
fi

if [ "$(uname)" == "Linux" ]; then
	ln -sfv "$DOTFILES_DIR/vim/vimrc" ~/.vimrc
fi
