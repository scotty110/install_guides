#!/bin/bash
# Installs all things terminal: alacritty, kitty, nvim, themes.

set -eu
# Check if Installing from main
if [ -z ${PARENT_DIR+x} ]; then
	CHILD_DIR=$PWD
else
	CHILD_DIR=$PARENT_DIR/terminal
fi

################
# Install nvim #
################
sudo dnf install -y neovim

# Install Neovim Configuration
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.vim/undodir"

cp "$CHILD_DIR/VIM/init.vim" "$HOME/.config/nvim/"

#################
# Install Fonts #
#################
mkdir -p "$HOME/.fonts"
cp -r "$CHILD_DIR/FONTS/"* "$HOME/.fonts/"

# Refresh the font cache
fc-cache -f -v

exit
