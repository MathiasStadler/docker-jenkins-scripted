# install jenkins src as eclipse project

## install eclipse

@ TODO describe install eclipse

## install maven

```bash
brew install maven
```

## clone jenkins repository

```bash
cd ~/playground
git clone https://github.com/jenkinsci/jenkins.git
```

## switch to and other current version

```bash
# be sure you have all tags local
# --all will fetch all the remotes.
# --tags will fetch all tags as well
git fetch --all --tags --prune

# list all tags
git tags
# maybe grep
git tag |grep jenkins-2.131
# e.g. switch to this tag version
git checkout tags/jenkins-2.131
# see branch
git branch
> * (HEAD detached at jenkins-2.131)
>  master
```

## run tests direct after git checkout

```txt
mvn -Plight-test install
```

## // generate .project and .classpath for Eclipse

```txt
mvn -DdownloadSources=true eclipse:eclipse
```

## compile jenkins

```bash
mvn clean install -pl war -am -DskipTests
```

## run jenkins

- [from here](https://wiki.jenkins.io/display/JENKINS/Starting+and+Accessing+Jenkins)

```bash
cd ./war/target
java -jar jenkins.war
```

## Debugging Jenkins

```bash
cd war
mvnDebug jenkins-dev:run
# or
mvn clean hpi:run
```

## old staff

## create eclipse workspace

```bash
mkdir ~/playground/workspace-eclipse-jenkins
```

## create eclipse jenkins project

- [from here](https://wiki.jenkins.io/display/JENKINS/Plugin+tutorial#Plugintutorial-Eclipse)

```bash
# change to git checkout directory
cd ~/playground/jenkins
# call maven
mvn -DdownloadSources=true -DdownloadJavadocs=true -DoutputDirectory=target/eclipse-classes -Declipse.workspace=$(pwd) eclipse:eclipse eclipse:configure-workspace
```

## WRONG

## import the project in eclipse

- open eclipse
- choose workspace ~/playground/workspace-eclipse-jenkins
- import

## Setting up Eclipse to build Jenkins

```txt
https://wiki.jenkins.io/display/JENKINS/Setting+up+Eclipse+to+build+Jenkins
```
