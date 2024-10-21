Run `./install.sh` first to do base install. The rest of this document will walk you through setting up the actual filesystem on multiple drives, as well as the other server software.

## Crypt Setup
Run the following (or the provided `crypt_setup.sh`) for each of the drives you wish to use (this sets up a LUKS block encryption that a filesystem can be installed on top of).
`setup_drive`
```
# Setup Crypto Header
sudo cryptsetup \
    --type luks2 \
    --cipher aes-xts-plain64 \
    --key-size 512 \
    --hash sha512 \
    --iter-time 10000 \
    --pbkdf argon2id \
    --use-urandom \
    --verify-passphrase \
    luksFormat \
    RAW_DRIVE

sudo cryptsetup open RAW_DRIVE CRYPT_DRIVE
```

Use [Strong Passwords](https://en.wikipedia.org/wiki/Password_strength)(64 chars)

Run the following from a macOS terminal to generate strong passwords
```
export LC_CTYPE=C
(tr -c -d '[:graph:]' < /dev/urandom | head -c64) | pbcopy
```

Then mount the drives using the command (be sure to give unique names)
```
sudo cryptsetup open RAW_DRIVE DRIVENAME 
```


### Set to Auto Mount
See: [Link](https://wiki.archlinux.org/title/Dm-crypt/System_configuration#Unlocking_with_a_keyfile)
For each drive you will need to run through the following process
1. Create a key File: `sudo dd if=/dev/random bs=512 count=1 of=/root/DRIVENAME_KEY`
2. Add key to crypt drive: `sudo cryptsetup luksAddKey PATH_TO_DRIVE /root/DRIVENAME_KEY`
2. Add keyfile to `/etc/cryttab`: `DRIVENAME    PATH_TO_DRIVE   /root/DRIVENAME_KEY`
3. Add map to `/etc/fstab` (Not needed): `/dev/mapper/DRIVENAME  MOUNT_PATH  ext4  defaults  0  0`

## Setup ZFS
Want to use ZFS for the features it provides. Data integrity is paramount.
See: [ubunut_overview](https://ubuntu.com/tutorials/setup-zfs-storage-pool#1-overview) , [arstechnica_overview](https://arstechnica.com/gadgets/2021/06/a-quick-start-guide-to-openzfs-native-encryption/) 
1. Install ZFS: `sudo apt install zfsutils-linux`
2. Make Pool (remove -n when ready to create): `zpool create -n -m /mnt/POOL_NAME POOL_NAME raidz1 /dev/mapper/DRIVES...`
3. 
	1. Make encrypted Z1 pool (use strong passphrase), set POOL_NAME to something like tank(?): `zfs create -o encryption=on -o keylocation=prompt -o keyformat=passphrase -o compression=lz4 POOL_NAME/encrypted` 
	2. Make encrypted Z1 pool (use keyfile), set POOL_NAME to something like tank(?): 
        `sudo dd if=/dev/random bs=32 count=1 of=/root/VAULT_KEY`
        `zfs create -o encryption=on -o keylocation=/root/VAULT_KEY -o keyformat=raw -o compression=lz4 POOL_NAME/encrypted` 
4. Make new r/w group: `sudo groupadd zfs-rw`
5. Add admin to zfs group: `sudo usermod -a -G zfs-rw ADMIN`
6. Change owner: `sudo chown -R ADMIN:zfs-rw /mnt/POOL_NAME`
7. Change Permissions: `chmod -R 770 /mnt/POOL_NAME`

## Unencrypted (might be faster)
1. Install ZFS: `sudo apt install zfsutils-linux`
2. Make Pool (remove -n when ready to create): `zpool create -n -m /mnt/POOL_NAME POOL_NAME raidz1 /dev/mapper/DRIVES...`
3. `zfs create -o compression=lz4 POOL_NAME/tank`
4. Make new r/w group: `sudo groupadd zfs-rw`
5. Add admin to zfs group: `sudo usermod -a -G zfs-rw ADMIN`
6. Change owner: `sudo chown -R ADMIN:zfs-rw /mnt/POOL_NAME`
7. Change Permissions: `chmod -R 770 /mnt/POOL_NAME`
8. Automount on startup: 
```
sudo systemctl enable zfs-import-cache.service
sudo systemctl enable zfs-mount.service
sudo systemctl enable zfs-import.target
sudo systemctl enable zfs.target
```
Add Entery to `/etc/fstab`: POOL_NAME/tank /mnt/POOL_NAME/tank zfs defaults 0 0

## Add User(s)
Add user with the following: `sudo adduser --ingroup zfs-rw USER`


## Setup Timemachine 
Sorta ripping from: [Link_1](https://saschaeggi.medium.com/use-a-raspberry-pi-4-for-time-machine-works-with-big-sur-1e66a9650789), [Link_2](https://tomverbeure.github.io/2023/06/25/ThinMachine-a-Thin-Client-MacOS-Time-Machine-Appliance.html) , [Link_3](https://news.ycombinator.com/item?id=36472534) 
1. Update: `sudo apt update && sudo apt upgrade`
2. Install samba and avahi: `sudo apt install samba avahi-daemon` 
3. Add User(s) to samba: `sudo smbpasswd -a USER`
4. Make timemachine folder: `mkdir /mnt/tank/encrypted/TIMEMACHINE_FOLDER` (could do for multiple users)
5. Edit `/etc/samba/smb.conf` for each timemachine: 
```
[TIMEMACHINE_URL]
        comment = Backups
        path = /mnt/tank/encrypted/TIMEMACHINE_FOLDER
        valid users = USER 
        read only = no
        vfs objects = catia fruit streams_xattr
        fruit:time machine = yes
```
6. Setup Avahi deamon:
```
<?xml version="1.0" standalone='no'?><!--*-nxml-*-->
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">
<service-group>
  <name replace-wildcards="yes">%h</name>
  <service>
    <type>_smb._tcp</type>
    <port>445</port>
  </service>
  <service>
    <type>_device-info._tcp</type>
    <port>9</port>
    <txt-record>model=TimeCapsule8,119</txt-record>
  </service>
  <service>
    <type>_adisk._tcp</type>
    <port>9</port>
    <txt-record>dk0=adVN=TIMEMACHINE_URL,adVF=0x82</txt-record>
    <txt-record>sys=adVF=0x100</txt-record>
  </service>
</service-group>
```
7. Allow samba through UFW: `sudo ufw allow samba`
8. Restart Samba: `sudo service smbd restart`
9. Restart Avahi: `sudo service avahi-daemon restart`


## Configure Samba
See: [Link](https://ubuntu.com/tutorials/install-and-configure-samba#3-setting-up-samba) 
1. Make dir
2. Add to Samba
```
[DIR_URL]
        comment = Backups
        path = /mnt/tank/encrypted/DIR
        valid users = USER 
        read only = no
        inherit permissions = yes
        browsable = yes
```
3. Restart Samba: `sudo service smbd restart`
4. Allow smb through UFW: `sudo ufw allow Samba`
5. Allow password auth:
```
[global]
security = user
passdb backend = tdbsam
```
Then add user to db: `sudo smbpasswd -a USER`


## Setup Tailscale
Install: `curl -fsSL https://tailscale.com/install.sh | sh`
Run: `sudo tailscale up`
Follow prompts to add to Tailscale network.

## Firewall
Setup basic firewall
See: [Link](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-20-04) 
1. Deny All
2. Allow SSH
3. Allow smb
4. Allow Tailscale: `sudo ufw allow in on tailscale0`
    https://tailscale.com/kb/1077/secure-server-ubuntu-18-04/
