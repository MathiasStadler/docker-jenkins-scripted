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

# for JENKINS REST_API
JENKINS_SERVER="192.168.178.97"
JENKINS_URL="http://admin:admin@$JENKINS_SERVER:8080"
JENKINS_API_USER="admin"
JENKINS_API_PASSWORD="admin"

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
	# from here
	# https://www.greenreedtech.com/creating-jenkins-credentials-via-the-rest-api/

	# @TODO copy private key to JENKINS-Master Virtualbox
	curl -X POST -u $JENKINS_API_USER:$JENKINS_API_PASSWORD $JENKINS_URL/credentials/store/system/domain/_/createCredentials --data-urlencode 'json={
  "": "0",
  "credentials": {
    "scope": "GLOBAL",
    "id": "apicredentials",
    "username": "apicredentials",
    "password": "",
    "privateKeySource": {
      "stapler-class": "com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey",
      "privateKey": "$(ssh-keygen -y -f  /home/vagrant_control/.ssh/private_key)",
    },
"description": "apicredentials",
"stapler-class": "com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey"
  }'

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
