#!/bin/bash
# Install Custom Scripts
# Encryption Support, Decryption support, wipeing drives, crypt setup ...

# Some Cool Repos
# GPG Encryption: https://github.com/SixArm/gpg-encrypt/blob/master/gpg-encrypt
# SSH Keys: https://github.com/SixArm/ssh-keygen-pro/blob/master/ssh-keygen-pro

set -eu
# Check if Installing from main
if [ -z ${PARENT_DIR+x} ]; then
	CHILD_DIR=$PWD
else
	CHILD_DIR=$PARENT_DIR/custom_scripts
fi

# Make $HOME/.custom_bin
export CUSTOM_SCRIPTS_DIR="$HOME/.custom_bin"
mkdir -p $CUSTOM_SCRIPTS_DIR

#Move files
cp $CHILD_DIR/scripts/* $CUSTOM_SCRIPTS_DIR/

cat >> $HOME/.crc << EOF

# Add custom scripts to Path
export CUSTOM_SCRIPTS_HOME="$CUSTOM_SCRIPTS_DIR"
export PATH="\$PATH:\$CUSTOM_SCRIPTS_HOME"

EOF


exit
