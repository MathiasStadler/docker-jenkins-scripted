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
JENKINS_SERVER="192.168.178.99"
JENKINS_URL="http://admin:admin@$JENKINS_SERVER:8080"
JENKINS_API_USER="admin"
JENKINS_API_PASSWORD="admin"

# global script variable
SSH_RSA=""
JSON_DATA=""
JSON_PRIVATE_KEY=""

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
	# old ssh-keygen -t rsa -N '' -f $USER_KEYS_NAME
	ssh-keygen -t rsa -f $USER_KEYS_NAME -q -P ""
	# create authorized_keys
	# authorized_keys file might not be present by default. If that’s the case, than create one
	cat ${USER_KEYS_NAME}.pub >authorized_keys

}

function validate_key_pair() {
	# from here
	# https://serverfault.com/questions/426394/how-to-check-if-a-rsa-public-private-key-pair-matched

	PRIVKEY=$HOME_DIR/.ssh/$USER_KEYS_NAME
	TESTKEY=$HOME_DIR/.ssh/$USER_KEYS_NAME.pub
	if (diff <(ssh-keygen -y -e -f "$PRIVKEY") <(ssh-keygen -y -e -f "$TESTKEY")); then

		echo "key pair match"

	else

		echo " Key pair  NOT match"

		exit 0

	fi

}

function check_private_key_has_passphrase() {

	# ATTENTION weak approach
	# from here
	# https://security.stackexchange.com/questions/129724/how-to-check-if-an-ssh-private-key-has-passphrase-or-not

	#The "RSA key" is actually a set of values stored as an ASN.1 structure
	# in the standardized DER binary format, then encoded in base-64 to get
	# the final PEM file. A very easy way to determine whether a key is encoded
	# or not is simply to check whether the ASN.1 header is present, and this is
	# usually as simple as checking if the "key" begins with the letters MII

	# Therefor check key begins with MII

	if (cat $HOME_DIR/.ssh/$USER_KEYS_NAME | grep '^MII'); then

		echo "Key has NO passphrase"

	else

		echo "Key has passphrase"

	fi

}

function change_owner_of_key_to_user() {

	# private key
	chown $USER $HOME_DIR/.ssh/$USER_KEYS_NAME

	# change group id to user gid
	chgrp $(id -g $USER) $HOME_DIR/.ssh/$USER_KEYS_NAME

	# change file mode bits
	chmod 0600 $HOME_DIR/.ssh/$USER_KEYS_NAME

	# public key
	chown $USER $HOME_DIR/.ssh/$USER_KEYS_NAME.pub

	# change group id to user gid
	chgrp $(id -g $USER) $HOME_DIR/.ssh/$USER_KEYS_NAME.pub

	# change file mode bits
	chmod 0600 $HOME_DIR/.ssh/$USER_KEYS_NAME.pub

	# authorized_keys
	chown $USER $HOME_DIR/.ssh/authorized_keys

	# change file mode bits
	chmod 0644 $HOME_DIR/.ssh/authorized_keys

}

function convert_private_key() {

	# convert RSA key => ssh-rsa key
	# from here
	# https://stackoverflow.com/questions/1011572/convert-pem-key-to-ssh-rsa-format/21290281
	SSH_RSA=$(ssh-keygen -y -f $HOME_DIR/.ssh/$USER_KEYS_NAME)

	echo "SSH_RSA KEY => ${SSH_RSA}"

}

function private_key_to_json() {

	# convert key to json
	JSON_PRIVATE_KEY=$(cat $HOME_DIR/.ssh/$USER_KEYS_NAME | jq -aR .)

}

function prepare_json_data() {

	KEY=$(cat $HOME_DIR/.ssh/$USER_KEYS_NAME)

	# prepare json and check
	JSON_DATA="{
  \"\": \"0\",
  \"credentials\": {
    \"scope\": \"GLOBAL\",
    \"id\": \"ID_${USER}\",
    \"username\": \"${USER}\",
    \"password\": \"\",
    \"privateKeySource\": {
      \"stapler-class\": \"com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey\$DirectEntryPrivateKeySource\",
	  \"privateKey\": \"${KEY}\"
    },
\"description\": \"${USER} for control remote host\",
\"stapler-class\": \"com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey\"
  }}"

	echo "JSON_DATA=>  $JSON_DATA"
	echo "$JSON_DATA" >/tmp/json.data

	JSON_DATA_2="{
          \"name\" : \"testcred\",
          \"description\" : \"test cred description\",
          \"json\" : {
            \"domainCredentials\" : {
              \"domain\" : {
                \"name\" : \"\",
                \"description\" : \"\"
              },
              \"credentials\" : {
                \"scope\" : \"GLOBAL\",
                \"id\" : \"\",
                \"username\" : \"root\",
                \"description\" : \"root users credential\",
                \"privateKeySource\" : {
                  \"value\" : \"0\",
                  \"privateKey\" : \"blah blah blah\",
                  \"stapler-class\" : \"com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey\$DirectEntryPrivateKeySource\"
                },
                \"passphrase\" : \"\",
                \"stapler-class\" : \"com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey\",
                \"kind\" : \"com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey\"
              }
            }
          }
        }"

	echo "${JSON_DATA_2}"
	echo "${JSON_DATA_2}" >/tmp/json2.data

}

function escape_json() {

	JSON_TOPIC_RAW=${JSON_DATA}

	# escape JSON_DATA
	# from here
	# https://stackoverflow.com/questions/10053678/escaping-characters-in-bash-for-json
	JSON_TOPIC_RAW=${JSON_TOPIC_RAW//\\/\\\\} # \
	JSON_TOPIC_RAW=${JSON_TOPIC_RAW//\//\\\/} # /
	JSON_TOPIC_RAW=${JSON_TOPIC_RAW//\'/\\\'} # ' (not strictly needed ?)
	# " already escape in this case
	# JSON_TOPIC_RAW=${JSON_TOPIC_RAW//\"/\\\"} # "
	# disable:
	# JSON_TOPIC_RAW=${JSON_TOPIC_RAW//   /\\t} # \t (tab)
	JSON_TOPIC_RAW=${JSON_TOPIC_RAW///\\\n}

	# \n (newline)
	JSON_TOPIC_RAW=${JSON_TOPIC_RAW//^M/\\\r} # \r (carriage return)
	JSON_TOPIC_RAW=${JSON_TOPIC_RAW//^L/\\\f} # \f (form feed)
	JSON_TOPIC_RAW=${JSON_TOPIC_RAW//^H/\\\b} # \b (backspace)
	# end

	JSON_DATA=${JSON_TOPIC_RAW}
	echo "$JSON_DATA" >/tmp/json_escape.data

}

function validate_json() {

	echo "$JSON_DATA" >/tmp/json_validate.data

	# from here
	# https://stackoverflow.com/questions/46954692/check-if-string-is-a-valid-json-with-jq

	if (echo "$JSON_DATA" | jq -e .); then
		echo "JSON_DAT data OK"
	else
		echo "JSON data wrong see messages please"
		exit 0
	fi

	if (echo "$JSON_DATA_2" | jq -e .); then
		echo "JSON_DATA_2 data OK"
	else
		echo "JSON_DATA_2 data wrong see messages please"
		exit 0
	fi

}

function create_credential_in_jenkins() {

	echo "create credential in jenkins"

	# from here
	# https://www.greenreedtech.com/creating-jenkins-credentials-via-the-rest-api/

	# @TODO copy private key to JENKINS-Master Virtualbox
	curl -X POST -u $JENKINS_API_USER:$JENKINS_API_PASSWORD $JENKINS_URL/credentials/store/system/domain/_/createCredentials --data-urlencode "json=${JSON_DATA}"

	# QUESTION Waht is => credentials/store/system/domain/_/newCredentials

	# /credentials/configSumbit
	# from here
	# https://github.com/arangamani/jenkins_api_client/issues/162
	# curl -X POST -u $JENKINS_API_USER:$JENKINS_API_PASSWORD $JENKINS_URL/credentials/store/system/domain/_/createCredentials --data-urlencode "json=${JSON_DATA_2}"

	# HINT for RSA key
	# https://github.com/arangamani/jenkins_api_client/issues/162
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
	validate_key_pair
	check_private_key_has_passphrase
	change_owner_of_key_to_user
	# TODO old ssh-rsa key doesn't work in jenkins convert_private_key
	# TODO check it is wrong private_key_to_json
	prepare_json_data
	escape_json
	validate_json
	create_credential_in_jenkins

fi
