# [Jenkins Script Console](https://wiki.jenkins.io/display/JENKINS/Jenkins+Script+Console)

## first sample

- install git plugin

```bash
JENKINS_SERVER="192.168.178.97"
URL="http://admin:admin@$JENKINS_SERVER:8080/scriptText"
curl -d "script=Jenkins.instance.updateCenter.getPlugin(\"ssh\")" $URL
```

## with dependencies

```bash
JENKINS_SERVER="192.168.178.97"
URL="http://admin:admin@$JENKINS_SERVER:8080/scriptText"
curl -d "script=Jenkins.instance.updateCenter.getPlugin(\"ssh\").getNeededDependencies().each{it.deploy()};Jenkins.instance.updateCenter.getPlugin(\"ssh\")" $URL
```

## check is a reboot necessary

```bash
JENKINS_SERVER="192.168.178.97"
URL="http://admin:admin@$JENKINS_SERVER:8080/scriptText"
curl -d "script=Jenkins.instance.updateCenter.isRestartRequiredForCompletion()" $URL
```

## restart jenkins

```bash
JENKINS_SERVER="192.168.178.97"
URL="http://admin:admin@$JENKINS_SERVER:8080"
USER="admin"
PASSWD="admin"
curl -X POST -u $USER:$PASSWD $URL/safeRestart

# from here
# https://support.cloudbees.com/hc/en-us/articles/216118748-How-to-Start-Stop-or-Restart-your-Instance-
curl -X POST -u $USER:$PASSWD $URL/restart
curl -X POST -u $USER:$PASSWD $URL/safeRestart
curl -X POST -u $USER:$PASSWD $URL/exit
curl -X POST -u $USER:$PASSWD $URL/safeExit
curl -X POST -u $USER:$PASSWD $URL/quietDown
curl -X POST -u $USER:$PASSWD $URL/cancelQuietDown
```

## add credentials

- [from here](https://www.greenreedtech.com/creating-jenkins-credentials-via-the-rest-api/)

```bash
TMP_FILE="/tmp/createCredentials.sh"
cat <<EOF > $TMP_FILE
#!/bin/bash
JENKINS_SERVER="192.168.178.97"
URL="http://admin:admin@$JENKINS_SERVER:8080":
USER="admin"
PASSWD="admin"
curl -X POST -u $USER:$PASSWD $URL/credentials/store/system/domain/_/createCredentials  --data-urlencode 'json={
  "": "0",
  "credentials": {
    "scope": "GLOBAL",
    "id": "apicredentials",
    "username": "apicredentials",
    "password": "",
    "privateKeySource": {
      "stapler-class": "com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey$DirectEntryPrivateKeySource",
      "privateKey": "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAklOUpkDHrfHY17SbrmTIpNLTGK9Tjom/BWDSUGPl+nafzlHDTYW7hdI4yZ5ew18JH4JW9jbhUFrviQzM7xlELEVf4h9lFX5QVkbPppSwg0cda3Pbv7kOdJ/MTyBlWXFCR+HAo3FXRitBqxiX1nKhXpHAZsMciLq8V6RjsNAQwdsdMFvSlVK/7XAt3FaoJoAsncM1Q9x5+3V0Ww68/eIFmb1zuUFljQJKprrX88XypNDvjYNby6vw/Pb0rwert/EnmZ+AW4OZPnTPI89ZPmVMLuayrD2cE86Z/il8b+gw3r3+1nKatmIkjn2so1d01QraTlMqVSsbxNrRFi9wrf+M7Q== schacon@mylaptop.local",
    },
    "description": "apicredentials",
    "stapler-class": "com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey"
  }
}'
EOF
chmod +x $TMP_FILE
```
