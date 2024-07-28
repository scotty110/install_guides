#!/bin/bash
# https://arstechnica.com/gadgets/2021/06/a-quick-start-guide-to-openzfs-native-encryption/

sudo zpool import 

#sudo zfs load-key -r /mnt/tank/encrypted
sudo zfs load-key -r tank/encrypted
sudo zfs mount -a
