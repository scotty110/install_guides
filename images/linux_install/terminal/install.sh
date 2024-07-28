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
sudo apt install -y \
	neovim \
	npm

# Install Python LSP
sudo npm i -g pyright

# Install vim-plug
# Need to run  ":PlugInstall"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install Configs
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.vim/undodir

cp $CHILD_DIR/VIM/init.vim $HOME/.config/nvim/
cp $CHILD_DIR/VIM/lsp_config.lua $HOME/.vim/


#################
# Install Fonts # 
#################
mkdir $HOME/.fonts
cp -r $CHILD_DIR/FONTS/* $HOME/.fonts/

exit
