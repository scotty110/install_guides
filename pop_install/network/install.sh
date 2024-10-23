#!/bin/bash
# Install Internet/Network Security Settings:

set -eu
# Check if Installing from main
if [ -z ${PARENT_DIR+x} ]; then
    CHILD_DIR=$PWD
else
    CHILD_DIR=$PARENT_DIR/network
fi

###################
# Install OpenSSH #
###################
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
sudo cp $CHILD_DIR/sshd_config /etc/ssh/

# Disable short Diffie-Hellman moduli
#sudo cp /etc/ssh/moduli /tmp/moduli.backup
sudo awk '$5 >= 3071' /etc/ssh/moduli > /tmp/moduli.tmp && sudo mv -f /tmp/moduli.tmp /etc/ssh/moduli

# Regenerate keys (512 bit security)
sudo ssh-keygen -t ecdsa -b 521 -f /etc/ssh/ssh_host_ecdsa_key
sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
sudo rm -f /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key.pub 



####################
# Install FireWall #
####################
sudo apt install -y ufw

# Set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH
sudo ufw allow ssh

# Enable UFW
sudo ufw enable

exit
