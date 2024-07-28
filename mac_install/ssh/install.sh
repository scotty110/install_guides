#!/bin/bash
# Setup Config

# Check if Installing from main
if [ -z ${PARENT_DIR+x} ]; then
    CHILD_DIR=$PWD
else
    CHILD_DIR=$PARENT_DIR/network
fi

set -eu

mkdif -p $HOME/.ssh

# Allow incoming SSH connections
# Will still need to allow macOS to allow SSH connections
sudo cp $CHILD_DIR/ssh/sshd_config /etc/ssh/sshd_config
