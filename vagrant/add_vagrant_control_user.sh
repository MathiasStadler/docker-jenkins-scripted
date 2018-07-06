#!/bin/bash

# Exit immediately if a command returns a non-zero status
set -e

# create new user vagrant_control
# from here
# https://unix.stackexchange.com/questions/79909/how-to-add-a-unix-linux-user-in-a-bash-script

USER="vagrant_control"
USER_KEYS_NAME="${USER}_KEY"
PASSWORD="vagrant_control"
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

# global script variable
SSH_RSA=""
JSON_DATA=""

function clean_old_home_directory() {

	if [ -e $HOME_DIR ]; then

		rm -rf $HOME_DIR
	fi

}

function create_user() {
	sudo adduser $USER --gecos "$FIRST_NAME $LAST_NAME,$ROOM_NUMBER,$WORK_PHONE,$HOME_PHONE" --disabled-password --home $HOME_DIR
}

function set_password() {
	# TODO avaid password for login
	echo "$USER:$PASSWORD" | sudo chpasswd
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
	ssh-keygen -t rsa -N '' -f $USER_KEYS_NAME
	# create authorized_keys
	# authorized_keys file might not be present by default. If that’s the case, than create one
	cat ${USER_KEYS_NAME}.pub >authorized_keys

}

function convert_private_key() {

	# convert RSA key => ssh-rsa key
	# from here
	# https://stackoverflow.com/questions/1011572/convert-pem-key-to-ssh-rsa-format/21290281
	SSH_RSA=$(ssh-keygen -y -f $HOME_DIR/.ssh/$USER_KEYS_NAME)

	echo "SSH_RSA KEY => ${SSH_RSA}"

}

function prepare_json_data() {

	# prepare json and check
	JSON_DATA="{
  \"\": \"0\",
  \"credentials\": {
    \"scope\": \"GLOBAL\",
    \"id\": \"apicredentials\",
    \"username\": \"apicredentials\",
    \"password\": \"\",
    \"privateKeySource\": {
      \"stapler-class\": \"com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey\",
      \"privateKey\": \"${SSH_RSA}\"
    },
\"description\": \"apicredentials\",
\"stapler-class\": \"com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey\"
  }}"

	echo "JSON_DATA =>  $JSON_DATA"

}

function validate_json() {

	echo "$JSON_DATA" >/tmp/json.data

	# from here
	# https://stackoverflow.com/questions/46954692/check-if-string-is-a-valid-json-with-jq

	if (echo "$JSON_DATA" | jq -e .); then
		echo "JSON data OK"
	else
		echo "JSON data wrong see messages please"
		exit 0
	fi

}

function create_credential_in_jenkins() {

	echo "create credential in jenkins"

	# from here
	# https://www.greenreedtech.com/creating-jenkins-credentials-via-the-rest-api/

	# @TODO copy private key to JENKINS-Master Virtualbox
	curl -X POST -u $JENKINS_API_USER:$JENKINS_API_PASSWORD $JENKINS_URL/credentials/store/system/domain/_/createCredentials --data-urlencode "json=${JSON_DATA}"

}

# main
# check user is exits
if (id -u $USER); then
	echo "User $USER is exits THE SCRIPTS WILL DO NOTHING"
	exit 0
else

	echo "Create new user $USER"
	clean_old_home_directory
	create_user
	set_password
	create_ssh_directory
	create_user_keys
	convert_private_key
	prepare_json_data
	validate_json
	create_credential_in_jenkins

fi
