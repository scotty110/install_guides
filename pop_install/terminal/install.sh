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
sudo apt install -y neovim

# Install Neovim Configuration
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.vim/undodir"

cp "$CHILD_DIR/init.vim" "$HOME/.config/nvim/"

# Install to rc
cat >> "$HOME/.crc" << EOF  

# Add Neovim 
alias vim="nvim"
EOF

exit
