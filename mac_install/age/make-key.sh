#!/bin/bash
rm -rf ~/.age
mkdir -p ~/.age
set -eu

KEY_FILE="scott_key"
touch ~/.age/$KEY_FILE
chmod 700 ~/.age/$KEY_FILE

age-keygen > ~/.age/$KEY_FILE
cat ~/.age/$KEY_FILE | grep -i '# public key' | sed 's/.*: //' > ~/.age/$KEY_FILE.pub
