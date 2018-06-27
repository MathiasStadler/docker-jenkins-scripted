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
