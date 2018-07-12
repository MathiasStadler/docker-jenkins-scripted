# install maven on debian

- [from here](https://tecadmin.net/install-apache-maven-on-debian/)

## **ATTENTION** The default / standard package was to old

## install tar.gz from apache-mirror

```bash
INSTALL_MAVEN_SCRIPT="install-maven-debian.sh"
cat <<EOF >"${INSTALL_MAVEN_SCRIPT}"
#!/bin/bash
# Exit immediately if a command returns a non-zero status
set -e
# PLEASE CHANGE/FIX anythings in  maven-install-debian.md thanks
MAVEN_FILE="apache-maven-3.5.4-bin.tar.gz"
PROFILE_D_FILE="/etc/profile.d/apache-maven.sh"
cd /usr/local || exit 1
sudo curl http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/\${MAVEN_FILE} -o /tmp/\${MAVEN_FILE}
sudo tar -xzf /tmp/\${MAVEN_FILE} -C /opt
sudo ln -f -s \${MAVEN_FILE} apache-maven
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" | sudo tee -a \${PROFILE_D_FILE} >/dev/null
echo "export M2_HOME=/usr/local/apache-maven" | sudo tee -a \${PROFILE_D_FILE} >/dev/null
echo "export MAVEN_HOME=/usr/local/apache-maven" | sudo tee -a \${PROFILE_D_FILE} >/dev/null
echo "export PATH=${M2_HOME}/bin:\${PATH}" | sudo tee -a \${PROFILE_D_FILE} >/dev/null
EOF
chmod +x "${INSTALL_MAVEN_SCRIPT}"
```
