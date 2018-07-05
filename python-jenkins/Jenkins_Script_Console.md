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
