#!/bin/bash
# Install Things

set -eu 

sudo apt upgrade \
    && sudo apt update -y

export PARENT_DIR=$PWD

# Make Custom src file
touch $HOME/.crc

cat >> $HOME/.bashrc << EOF

# Enable custom rc
if [ -f ~/.crc ]; then
    . ~/.crc
fi
EOF

# Install Networking
sh $PARENT_DIR/network/install.sh 
sh $PARENT_DIR/network/gen_key.sh 

# Install Custom Scripts
sh $PARENT_DIR/custom_scripts/install.sh

# Clean up
sudo rm -rf /var/lib/apt/lists/*

exit
