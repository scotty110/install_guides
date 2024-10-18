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
sudo dnf install -y firewalld

sudo firewall-cmd --set-default-zone=drop
sudo firewall-cmd --zone=drop --add-service=ssh --permanent
sudo firewall-cmd --zone=public --set-target=ACCEPT --permanent
sudo firewall-cmd --reload

sudo systemctl start firewalld
sudo systemctl enable firewalld

# Verify
sudo systemctl restart sshd
sudo sshd -T | grep -E 'kex|ciphers|macs|hostkey'

exit
