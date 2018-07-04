# [Jenkins Script Console](https://wiki.jenkins.io/display/JENKINS/Jenkins+Script+Console)

## first sample

- install git plugin

```bash
curl -d "script=Jenkins.instance.updateCenter.getPlugin(\"git\")" http://admin:admin@192.168.178.96:8080/scriptText
```

## check is a reboot necessary

```bash
curl -d "script=Jenkins.instance.updateCenter.isRestartRequiredForCompletion()" http://admin:admin@192.168.178.96:8080/scriptText
```
