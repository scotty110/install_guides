#!/bin/bash
# Copy Terminal to Desktop

# Check if Installing from main
if [ -z ${PARENT_DIR+x} ]; then
    CHILD_DIR=$PWD
else
    CHILD_DIR=$PARENT_DIR/network
fi

set -eu

cp $CHILD_DIR/*.terminal $HOME/Desktop/

# Notes for Nord Terminal
# https://www.nordtheme.com

# Setup cute terminal
touch $HOME/.zshrc
# export PS1="%F{green}(/^ヮ^)/ %F{blue}%~ %f$ "
# export PS1="%F{green}༼ つ ◕_◕ ༽つ %F{blue}%~ %f$ "

cat >> $HOME/.zshrc << EOF
export PS1="%F{green}༼ つ ◕_◕ ༽つ %F{blue}%~ %f$ "
# export PS1="%F{green}(/^ヮ^)/ %F{blue}%~ %f$ "
EOF
