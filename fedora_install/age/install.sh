#!/bin/bash

set -eu
# Check if Installing from main
if [ -z ${PARENT_DIR+x} ]; then
	CHILD_DIR=$PWD
else
	CHILD_DIR=$PARENT_DIR/DIR
fi

# Install Age
sudo dnf install -y age

# Add Age to crc
cat >> "$HOME/.crc" << EOF

# AGE
export AGE_PUB=
export AGE_KEY=

EOF

exit
