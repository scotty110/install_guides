#!/bin/bash
# Check if Installing from main
if [ -z ${PARENT_DIR+x} ]; then
    CHILD_DIR=$PWD
else
    CHILD_DIR=$PARENT_DIR/network
fi

set -eu

brew install age

rm -rf ~/.age
mkdir -p ~/.age

cat >> $HOME/.crc << EOF

# AGE
export AGE_PUB=
export AGE_KEY=

EOF

exit
