#!/bin/bash

# for info if cache dir mounted before script running
mount >/tmp/mount.txt

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
	python-packaging

exit 0
git clone git://github.com/ansible/ansible.git &&
	cd ansible &&
	git checkout "$(git branch -a | grep stable | tail -1 | cut -d "/" -f 3)" &&
	make &&
	make install
