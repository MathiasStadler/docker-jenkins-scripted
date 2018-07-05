#!/bin/bash

# create new user vagrant_control
# from here
# https://unix.stackexchange.com/questions/79909/how-to-add-a-unix-linux-user-in-a-bash-script

USER="vagrant_control"
PASSWD="vagrant_control"
HOME_DIR="/home/vagrant_control"
FIRST_NAME="Vagrant"
LAST_NAME="Control"
ROOM_NUMBER=""
WORK_PHONE=""
HOME_PHONE=""

function create_user() {
	sudo adduser $USER --gecos "$FIRST_NAME $LAST_NAME,$ROOM_NUMBER,$WORK_PHONE,$HOME_PHONE" \ --disabled-password --home $HOME_DIR
}

function set_password() {
	# TODO avaid password for login
	echo "$USER:$PASSWD" | sudo chpasswd
}

function create_ssh_directory() {
	if ! [ -e $HOME_DIR/.ssh ]; then
		mkdir $HOME_DIR/.ssh
	fi
}

function create_user_keys() {

	# change to .ssh directory
	cd $HOME_DIR/.ssh
	# create key
	ssh-keygen -t rsa -f for_jenkins_key
	# create authorized_keys
	# authorized_keys file might not be present by default. If that’s the case, than create one
	cat for_jenkins_key.pub >authorized_keys

}

function create_credential_in_jenkins() {

	echo "create credential in jenkins"
	# @TODO copy private key to JENKINS-Master Virtualbox
}

# main
# check user is exits
if (id -u $USER); then
	echo "User $USER is exits THE SCRIPTS WILL DO NOTHING"
	exit 0
else

	echo "Create new user $USER"
	create_user
	set_password
	create_ssh_directory
	create_user_keys
	create_credential_in_jenkins

fi
