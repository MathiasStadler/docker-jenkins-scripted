# docker-jenkins-scripted

manage jenkins complete with scripts, ansible, python-jenkins

## TL;DR

- start vagrant box

```bash
cd vagrant
vagrant up
```

- deploy ansible jenkins role
  -- all roles in the repository

```bash

```

## docker

25 cd $\_
26 mkdir roles
27 vi ansible.cfg
28 export ANSIBLE_CONFIG=$(pwd)/ansible.cfg
29 cat $ANSIBLE_CONFIG
30 ip a
31 vi hosts
32 export ANSIBLE_HOSTS=$(pwd)/hosts
33 vi requirements.yml
34 ansible-galaxy install -r requirements.yml

ip route get $(dig +short google.com | tail -1) | grep $(dig +short google.com | tail -1)| awk '{print $5}').chomp

mount -o vers=3,udp,uid=0,gid=0 172.28.128.1:/home/trapapa/.vagrant.d/cache/apt/debian/contrib-stretch64 /var/cache/apt/archives

## trouble shooting

```txt
mount.nfs: an incorrect mount option was specified
```

## netx

```txt
Shared folders that have NFS enabled do not support owner/group
```

## install dig

```bash
sudo apt-get install dnsutils
```

## show VirtualBox shared folder

```bash
# get name or id from running vm
> VBoxManage list runningvms
# show all information
# VBoxManage showvminfo <name|id>
> VBoxManage showvminfo vagrant-stretch64-docker-jenkins
# used the --machinereadable format and grep for SharedFolder
> VBoxManage showvminfo vagrant-stretch64-docker-jenkins --machinereadable |grep SharedFolder

# help
> VBoxManage showvminfo --help
```

vagrant on /vagrant type vboxsf (rw,nodev,relatime)
var*cache_apt_archives* on var*cache_apt_archives* type vboxsf (rw,nodev,relatime)

## works mount

```bash
# bad because is with backtick
sudo mount -t vboxsf -o uid=`id -u vagrant`,gid=`id -g vagrant` var_cache_apt_archives_ /var/cache/apt/archives
# better with inline
sudo mount -t vboxsf -o uid=$(id -u vagrant),gid=$(id -g vagrant) var_cache_apt_archives_ /var/cache/apt/archives
```

```txt
VM must be created before running this command. Run `vagrant up` first.
```

```bash
lsmod | grep -io vboxguest | xargs modinfo | grep -iw version
```

```txt
INFO subprocess: Starting process: ["/usr/bin/VBoxManage", "guestproperty", "get", "d1f61fa9-b925-4086-a638-de57639cccc5", "/VirtualBox/GuestAdd/Version"]
```

## get version

- [from here](https://stackoverflow.com/questions/19807888/cut-the-first-and-the-last-part-of-a-string-in-bash)

echo $(VBoxManage --version | sed -E 's/r[^r]\*$//')

## vagrant file provider

```bash
# write VirtualBoxHostVersion into guest vm for vbguest extension installation
%x(VBoxManage --version | sed -E 's/r[^r]\*$//' >/tmp/VirtualBoxHostVersion.txt)
config.vm.provision "file", source: "/tmp/VirtualBoxHostVersion.txt", destination: "/VirtualBoxHostVersion.txt"
```

```txt
Verifying archive integrity... All good.
About to extract 7992 KB in /tmp/selfgz15242 ... Proceed
```
