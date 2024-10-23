#!/bin/bash

set -eu 

# Update and upgrade packages
sudo apt clean \
    && sudo apt update \
    && sudo apt upgrade -y

export PARENT_DIR=$PWD

# Make Custom src file
touch "$HOME/.crc"

cat >> "$HOME/.bashrc" << EOF

# Enable custom rc
if [ -f ~/.crc ]; then
    . ~/.crc
fi
EOF

# Install Terminal
sh "$PARENT_DIR/terminal/install.sh"

# Install Networking
sh "$PARENT_DIR/network/install.sh" 
sh "$PARENT_DIR/network/gen_key.sh"

# Install Python
sh "$PARENT_DIR/python/install.sh"

# Install Custom Scripts
sh "$PARENT_DIR/custom_scripts/install.sh"

exit
