#!/bin/bash
# Install Custom Scripts
# Encryption Support, Decryption support, wipeing drives, crypt setup ...

# Some Cool Repos
# GPG Encryption: https://github.com/SixArm/gpg-encrypt/blob/master/gpg-encrypt
# SSH Keys: https://github.com/SixArm/ssh-keygen-pro/blob/master/ssh-keygen-pro

set -eu
# Check if Installing from main
if [ -z ${BUILD_DIR+x} ]; then
	CHILD_DIR=$PWD
else
	CHILD_DIR=$BUILD_DIR/custom_scripts
fi

sudo apt install -y git

# Download Custom Scripts
export CUSTOM_SCRIPTS_DIR="$HOME/.custom_bin"
git clone https://github.com/scotty110/linux_scripts.git $CUSTOM_SCRIPTS_DIR 
rm -rf $CUSTOM_SCRIPTS_DIR/.git

cat >> "$HOME/.crc" << EOF

# Add custom scripts to Path
export CUSTOM_SCRIPTS_HOME="$CUSTOM_SCRIPTS_DIR"
export PATH="\$PATH:\$CUSTOM_SCRIPTS_HOME"

EOF

exit
