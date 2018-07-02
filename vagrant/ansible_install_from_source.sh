#!/bin/bash

# get filename
readonly FILENAME=$(basename "$0")

# for info if cache dir mounted before script running
echo "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}" >"/tmp/mount_$FILENAME.txt"

# blank line
echo "mounts before run this script" >>"/tmp/mount_$FILENAME.txt"
mount >>/tmp/mount_"$FILENAME".txt

# for test situation
# TODO must be scripted
exit 0

# from here https://linuxconfig.org/ansible-installation-on-debian-9-stretch-linux-from-source
export DEBIAN_FRONTEND=noninteractive
apt update && apt install -y make \
	git \
	make \
	python-setuptools \
	gcc \
	python-dev \
	libffi-dev \
	libssl-dev \
	python-packaging &&
	git clone git://github.com/ansible/ansible.git &&
	cd ansible &&
	git checkout "$(git branch -a | grep stable | tail -1 | cut -d "/" -f 3)" &&
	make &&
	make install
