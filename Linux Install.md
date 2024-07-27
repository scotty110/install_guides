Going to be installing stuff on top of PopOS, but this should work for other ubuntu based distro's. PopOS was chosen due to shipping with Nvidia drivers, and I just can't be bothered. 

Install PopOS according to installer (don't forget encryption, ssd's can't be wiped)

## Install Basic Utils
Just Install some basic packages and custom scripts
### On Host 
1. Put authorized keys in `./install_package` (scripts will disable password ssh)
2. Move bundle to server `rsy ./install_package USER@REMOTE_HOST:/home/USER`
3. SSH into REMOTE_HOST
### On Remote Host
1. `cd install_package`
2. Run `./install.sh`
3. Follow (and possibly debug) and instructions
4. PLACE `authorized_keys` in `~/.ssh/` DO NOT FORGET
### Update
1. Exit ssh shell
2. SSH back into REMOTE_HOST (reset paths and stuff).
3. Run `update` 

## Auto Mount extra drives
If we have extra drives, then we want to auto mount them. 

NOTE: If dealing with SATA drives, use `cwipe` or `rwipe` this will dump random bits to the drive. This does not need to be done for NVME or SSD drives (since wear leveling)

1. Create LUKS drive using `setup_drive`. 
	1. Use `pw` on HOST machine. 
2. Add Random Bytes as password for drive. 
	1. `sudo dd if=/dev/random bs=512 count=1 of=/root/DRIVENAME_KEY`
	2. `sudo cryptsetup luksAddKey PATH_TO_DRIVE /root/DRIVENAME_KEY`
3. Modify so auto mount on boot
	1. `sudo vi /etc/cryttab` : `DRIVENAME    PATH_TO_DRIVE   /root/DRIVENAME_KEY`
	2. `sudo vi /etc/fstab`  :  `/dev/mapper/DRIVENAME  MOUNT_PATH  ext4  defaults  0  0` 

## Docker and Nvidia Runtime
Some projects are using docker with Nvidia gpu's enabled. 
### Install Docker
Follow: [Link](https://docs.docker.com/engine/install/ubuntu/)
Make sure to do post install: [Link](https://docs.docker.com/engine/install/linux-postinstall/)
### Nvidia Runtime
After installing Docker follow [Link](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) 

## Tor 
1. Add the latest Repository [Link](https://support.torproject.org/apt/tor-deb-repo/)
2. Add Website: [Link](https://community.torproject.org/onion-services/setup/)
3. Make Relay [Link](https://community.torproject.org/relay/setup/guard/debian-ubuntu/)
	1. Make sure to add port forwarding rule on router