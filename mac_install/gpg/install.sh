#!/bin/bash
# Install gpg and encryption scritps (for yubikey support)

# Check if Installing from main
if [ -z ${PARENT_DIR+x} ]; then
    CHILD_DIR=$PWD
else
    CHILD_DIR=$PARENT_DIR/network
fi

set -eu

export CHILD_DIR="$BUILD_DIR/gpg"

# Install GPG and tools needed for GPG key
#brew install gpg pinentry-mac 
brew install gpg ykman

# Add gpg home dir
mkdir -p $HOME/.gnupg

# Tell GPG to enable ssh support and add support for pinkey
export GPG_AGENT_CONF="$HOME/.gnupg/gpg-agent.conf"
touch $GPG_AGENT_CONF

cat >> $GPG_AGENT_CONF << EOF
default-cache-ttl 600
max-cache-ttl 7200
pinentry-program /usr/local/bin/pinentry-tty
EOF

# Tell GPG what settings to use as defaults
export GPG_CONF="$HOME/.gnupg/gpg.conf"
touch $GPG_CONF

cat >> $GPG_CONF << EOF
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
chown -R $(whoami) $HOME/.gnupg/

find $HOME/.gnupg -type f -exec chmod 600 {} \;
find $HOME/.gnupg -type d -exec chmod 700 {} \;

# Add GPG to allow encrypt and decrypt
cat >> $HOME/.crc << EOF

# GPG User
export GPG_USER_NAME=

EOF