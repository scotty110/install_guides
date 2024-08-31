#!/bin/bash
# Set up and configure Vim

# Check if Installing from main
if [ -z ${BUILD_DIR+x} ]; then
	CHILD_DIR=$PWD
else
	CHILD_DIR=$BUILD_DIR/custom_scripts
fi
set -eu

# Using NeoVim as editor
brew install neovim

# Tell zsh to use neovim as default editor
cat >> $HOME/.crc << EOF

# Set neovim as defualt editor
export EDITOR="nvim"
export VISUAL="nvim"
alias vi="nvim"

EOF

####################
# Configure neovim #
####################

# Make Config dir for neovim
export NV_CONFIG=$HOME/.config/nvim
mkdir -p $NV_CONFIG

# Add Colorscheme home for NeoVim
#mkdir -p $NV_CONFIG/colors
#cp -r $CHILD_DIR/colors/* $NV_CONFIG/colors/


# Copy init.vim
# Adapted from: https://github.com/erkrnt/awesome-streamerrc/tree/master/ThePrimeagen
cp $CHILD_DIR/init.vim $NV_CONFIG/init.vim




