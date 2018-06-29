#!/bin/bash

set -e

# clone repo
git clone https://github.com/geerlingguy/ansible-role-jenkins.git

# change into directory
cd ansible-role-jenkins

# check syntax is compatible with ansible version
ansible-playbook --syntax-check playbook.yml

# install requirements
ansible-galaxy install -r requirements.yml

# run playbook
ansible-playbook playbook.yml
