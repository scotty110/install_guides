#!/bin/bash
# Generate SSH Key
set -eu

ssh-keygen -t ed25519 -b 512 -f ~/.ssh/my_id

exit
