#!/bin/bash
set -e

# from here
# https://gist.github.com/hollodotme/9388876996845ed7397d

# we provide the VirtualBox host version with a vagrant file provision
# config.vm.provision "file", source: "/tmp/VirtualBoxHostVersion.txt", destination: "/home/vagrant/VirtualBoxHostVersion.txt"

VERSION=$(cat /home/vagrant/VirtualBoxHostVersion.txt)

# variable
CACHE_DIRECTORY="/var/cache/apt/archives"
VBOX_GUEST_ADDITIONS="VBoxGuestAdditions_$VERSION.iso"
LOOP_MOUNT_POINT="/media/VBoxGuestAdditions"
# uninstall
if dpkg --list | grep virtualbox-guest; then

	apt-get -y -q purge virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
else
	echo "No DEP packages for virtualbox installed"
fi
sudo apt-get update
sudo apt-get install -y linux-headers-$(uname -r)
sudo apt-get install -y curl build-essential dkms
cd $CACHE_DIRECTORY
if [ ! -f $VBOX_GUEST_ADDITIONS ]; then
	sudo curl -O "http://download.virtualbox.org/virtualbox/$VERSION/$VBOX_GUEST_ADDITIONS"
else echo "File already there"; fi
sudo mkdir -p $LOOP_MOUNT_POINT
if mount | grep $LOOP_MOUNT_POINT >/dev/null; then
	sudo umount $LOOP_MOUNT_POINT
fi
sudo mount -o loop,ro "$CACHE_DIRECTORY/VBoxGuestAdditions_$VERSION.iso" $LOOP_MOUNT_POINT
# from here
# https://github.com/dotless-de/vagrant-vbguest/issues/252
# disable exit on error for this error
# Could not find the X.Org or XFree86 Window System, skipping
# subshell
(set +x sudo sh $LOOP_MOUNT_POINT/VBoxLinuxAdditions.run --nox11 -- --force) &

wait # Don't execute the next command until subshells finish.

sudo umount $LOOP_MOUNT_POINT
# we used cache directory not delete for the next vm sudo rm -rf "VBoxGuestAdditions_$VERSION.iso"
sudo rmdir $LOOP_MOUNT_POINT

echo "VBox Linux Addition info"
/sbin/modinfo vboxsf
/sbin/modinfo vboxvideo
