#!/bin/bash
# Install fonts for MacOS

# Check if Installing from main
if [ -z ${PARENT_DIR+x} ]; then
    CHILD_DIR=$PWD
else
    CHILD_DIR=$PARENT_DIR/network
fi

set -eu


export fonts_home="$HOME/Library/Fonts"
cp $CHILD_DIR/fonts/* $fonts_home/

# Install Plex
#wget https://github.com/IBM/plex/releases/download/v4.0.2/OpenType.zip 
#unzip OpenType.zip 
#find ./OpenType/ -name '*.otf' -exec mv {} $fonts_home/ \;
#rm OpenType*

# Install Adobe Source Code Pro
#wget https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.otf -P $fonts_home/
#wget https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.otf -P $fonts_home/

# Web sites
# https://github.com/tonsky/FiraCode
# https://github.com/intel/intel-one-mono
# https://github.com/adobe-fonts/source-code-pro
# https://github.com/IBM/plex
# https://dtinth.github.io/comic-mono-font/
# https://github.com/JetBrains/JetBrainsMono 

# VSCode
# system_profiler -json SPFontsDataType | grep \"family | sort | uniq
# 'Source Code Pro', Menlo, Monaco, 'Courier New', monospace

