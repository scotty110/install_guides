## Nvidia Drivers 
1. Install DKMS
	1. `sudo dnf update -y`
	3. `sudo dnf install -y epel-release`
	4. `sudo dnf install -y kernel-devel kernel-headers gcc make perl`
	5. `sudo dnf install -y dkms` 
2. Install [Nvidia Driver](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64) 
	- Use Network install NOT local
	1. `sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel9/x86_64/cuda-rhel9.repo`
	2. `sudo dnf -y module install nvidia-driver:open-dkms` 
## Base Install
1. Install rsync on server: `sudo dnf install -y rsync`
2. Copy `rocky_install` to machine
3. Copy `authorized_keys` file to machine
4. Run `rocky_install/install.sh`
5. Move `authorized_keys` to `.ssh` 
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
	2. `sudo vi /etc/fstab`  :  `/dev/mapper/DRIVENAME  MOUNT_PATH  xfs  defaults  0  0` 
4. Edit permissions: `sudo chown -R $USER:$USER MOUNT_PATH`
5. Create link: `ln -s target_file link_name`
## Resize /
We are using as a single user so just grow the `/` partition.
1. Extend lvm: `sudo lvextend -l +100%FREE /dev/mapper/fedora-root`
2. Resize filesystem (xfs): `sudo xfs_growfs /`
## Docker and Nvidia Runtime
Some projects are using docker with Nvidia gpu's enabled. 
### Install Docker
Follow: [Link](https://docs.docker.com/engine/install/fedora/)
Make sure to do post install: [Link](https://docs.docker.com/engine/install/linux-postinstall/)
### Nvidia Runtime
After installing Docker follow [Link](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) 
