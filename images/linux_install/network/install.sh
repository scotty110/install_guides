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
sudo apt install -y \
	openssh-client \
	openssh-server

mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
sudo cp $CHILD_DIR/sshd_config /etc/ssh/

# Disable short Diffie-Hellman moduli
#sudo cp /etc/ssh/moduli /tmp/moduli.backup
sudo awk '$5 >= 3071' /etc/ssh/moduli > /tmp/moduli.tmp && sudo mv -f /tmp/moduli.tmp /etc/ssh/moduli


####################
# Install FireWall #
####################
sudo apt install -y ufw
# Use UFW to secure network connections
sudo ufw default deny incoming \
	&& sudo ufw default allow outgoing \
	&& sudo ufw allow OpenSSH \
	&& sudo ufw enable

############
# Websites #
############

# https://ubuntu.com/server/docs/service-openssh
# https://infosec.mozilla.org/guidelines/openssh.html
# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04
# https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands
# https://wiki.ubuntu.com/UncomplicatedFirewall
exit
