#!/bin/bash
# PLEASE CHANGE/FIX anythings in  maven-install-debian.md thanks
MAVEN_FILE="apache-maven-3.5.4-bin.tar.gz"
PROFILE_D_FILE="/etc/profile.d/apache-maven.sh"
cd /usr/local || exit 1
sudo wget http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/${MAVEN_FILE} -o /tmp
sudo tar xzf ${MAVEN_FILE} -C /opt
sudo ln -s ${MAVEN_FILE} apache-maven
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" | sudo tee -a ${PROFILE_D_FILE} >/dev/null
echo "export M2_HOME=/usr/local/apache-maven" | sudo tee -a ${PROFILE_D_FILE} >/dev/null
echo "export MAVEN_HOME=/usr/local/apache-maven" | sudo tee -a ${PROFILE_D_FILE} >/dev/null
echo "export PATH=/bin:${PATH}" | sudo tee -a ${PROFILE_D_FILE} >/dev/null