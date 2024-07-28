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

# Install Terminal
sh $PARENT_DIR/terminal/install.sh 

# Install Networking
sh $PARENT_DIR/network/install.sh 
sh $PARENT_DIR/network/gen_key.sh 

# Install python
sh $PARENT_DIR/python/install.sh

# Install Age
sh $PARENT_DIR/age/install.sh

# Install Custom Scripts
sh $PARENT_DIR/custom_scripts/install.sh

# Move Notes to Desktop
cp $PARENT_DIR/notes/*.txt $HOME/Desktop/


# Clean up
sudo rm -rf /var/lib/apt/lists/*

exit
