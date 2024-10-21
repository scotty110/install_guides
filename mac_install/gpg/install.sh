#!/bin/bash
# Install gpg and encryption scritps (for yubikey support)

# Check if Installing from main
if [ -z ${PARENT_DIR+x} ]; then
    CHILD_DIR=$PWD
else
    CHILD_DIR=$PARENT_DIR/network
fi

set -eu

# Create GPG home directory
mkdir -p "$HOME/.gnupg"

# Configure GPG settings
cat > "$HOME/.gnupg/gpg.conf" << EOF
auto-key-retrieve
no-emit-version
cipher-algo aes256
digest-algo sha512
cert-digest-algo sha512
compress-algo none -z 0
s2k-mode 3
s2k-digest-algo sha512
s2k-count 65011712
force-mdc
quiet
no-greeting
pinentry-mode loopback
EOF

# Fix GPG permissions
chown -R "$(whoami)" "$HOME/.gnupg/"
chmod 600 "$HOME/.gnupg/"*
chmod 700 "$HOME/.gnupg/"*

# Add GPG to allow encrypt and decrypt
cat >> "$HOME/.crc" << EOF

# GPG User
export GPG_USER_NAME=

EOF