#!/bin/bash

#!/bin/bash

# Exit immediately if a command returns a non-zero status
set -e

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
JENKINS_SERVER="192.168.178.100"
JENKINS_URL="http://admin:admin@$JENKINS_SERVER:8080"
JENKINS_API_USER="admin"
JENKINS_API_PASSWORD="admin"

function prepare_json_data() {

	# get JSON data
	# http://192.168.178.100:8080/descriptorByName/org.jvnet.hudson.plugins.SSHBuildWrapper/fillCredentialIdItems

	# http://192.168.178.100:8080/descriptorByName/org.jvnet.hudson.plugins.SSHBuildWrapper/loginCheck

	# http://192.168.178.100:8080/descriptorByName/org.jvnet.hudson.plugins.CredentialsSSHSite

	JSON_DATA="{



    }"

	_JSON_DATA="{
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

}

function create_ssh_site_in_jenkins() {

	echo "create ssh sites in jenkins"

	curl $JENKINS_URL/descriptorByName/org.jvnet.hudson.plugins.SSHBuildWrapper/loginCheck \
		-X POST \
		-u $JENKINS_API_USER:$JENKINS_API_PASSWORD \
		-d hostname=192.168.178.33 \
		-d port=22 \
		-d credentialId=ID_vagrant_control \
		-d timeout=100

}

create_ssh_site_in_jenkins
