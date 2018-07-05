#!/bin/bash
JENKINS_SERVER="192.168.178.97"
URL="http://admin:admin@:8080":
USER="admin"
PASSWD="admin"
curl -X POST -u admin:admin http://192.168.178.97:8080/credentials/store/system/domain/_/createCredentials --data-urlencode 'json={
  "": "0",
  "credentials": {
    "scope": "GLOBAL",
    "id": "apicredentials",
    "username": "apicredentials",
    "password": "",
    "privateKeySource": {
      "stapler-class": "com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey",
      "privateKey": "$(ssh-keygen -y -f /home/vagrant_control/.ssh/private_key)",
    },
"description": "apicredentials",
"stapler-class": "com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey"
  }
}'
