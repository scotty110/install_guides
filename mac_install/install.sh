#!/bin/bash
# Install script for macOS

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Error: Homebrew is not installed. Please install Homebrew from https://brew.sh/ and try again."
    exit 1
fi

export BUILD_DIR="$PWD"

# make ~/.crc to install custom stuff to 
touch $HOME/.crc 
cat >> $HOME/.crc << EOF
# Custom Stuff for Terminal

EOF


# Install gpg tools
sh ./gpg/install.sh

# Install pass
sh ./pass/install.sh

# Install Fonts
sh ./fonts/install.sh

# Install Terminal
sh ./terminal/install.sh

# Install Custom Scripts
sh ./custom_scripts/install.sh

# Install Vim
sh ./vim/install.sh

# Install SSH
sh ./ssh/install.sh
sh ./ssh/gen_key.sh

# Install Age
sh ./age/install.sh

cat >> $HOME/.zprofile << EOF

# Add CRC
if [ -f ~/.crc ]; then
	source ~/.crc
fi

EOF


