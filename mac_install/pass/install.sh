#!/bin/bash
# Install and configureation for pass store
# https://www.passwordstore.org

# Check if Installing from main
if [ -z ${PARENT_DIR+x} ]; then
    CHILD_DIR=$PWD
else
    CHILD_DIR=$PARENT_DIR/network
fi

set -eu

brew install pass 

# Init pass
pass init
mkdir -p $HOME/.password-store/

exit