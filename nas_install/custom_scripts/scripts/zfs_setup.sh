#!/bin/bash
#zpool create -m /mnt/tank tank raidz1 /dev/mapper/crypt_sdb /dev/mapper/crypt_sdc /dev/mapper/crypt_sdd
zfs create -o encryption=on -o keylocation=prompt -o keyformat=passphrase -o compression=lz4 tank/encrypted
