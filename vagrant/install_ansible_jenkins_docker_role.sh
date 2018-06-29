#!/bin/bash

# Exit immediately if a command returns a non-zero status
set -e

# set variables
export ANSIBLE_HOSTS=$(pwd)/hosts
export ANSIBLE_CONFIG=$(pwd)/ansible.cfg

# clone repo
git clone https://github.com/geerlingguy/ansible-role-jenkins.git

# change into directory
cd ansible-role-jenkins

# create hosts file
cat <<HOSTS >hosts
127.0.0.1
HOSTS

# create ansible.cfg
cat <<ANSIBLE_CONF >ansible.yml
[defaults]
roles_path=~/.ansible/roles
ANSIBLE_CONF

cat <<REQUIREMENTS >requirements.yml
- src: https://github.com/angstwad/docker.ubuntu
  name: angstwad.docker.ubuntu
  version: master

- src: https://github.com/geerlingguy/ansible-role-jenkins
  name: geerlingguy.jenkins
  version: master
REQUIREMENTS

# create playbook.yml
cat <<PLAYBOOK >playbook.yml
---
- hosts: all
  remote_user: vagrant
  become: yes
  become_method: sudo
  roles:
    - geerlingguy.java
    - geerlingguy.jenkins
PLAYBOOK

# check syntax is compatible with ansible version
ansible-playbook --syntax-check playbook.yml

# install requirements
ansible-galaxy install -r requirements.yml

# run playbook
ansible-playbook playbook.yml
