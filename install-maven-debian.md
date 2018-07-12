# install maven on debian

- [from here](https://tecadmin.net/install-apache-maven-on-debian/)

## **ATTENTION** The default / standard package was to old

## install tar.gz from apache-mirror

```bash
INSTALL_MAVEN_SCRIPT="install-maven-debian.sh"
cat <<EOF >'"${INSTALL_MAVEN_SCRIPT}"'
#!/bin/bash
# Exit immediately if a command returns a non-zero status
set -e
# PLEASE CHANGE/FIX anythings in  maven-install-debian.md thanks
COMMENT="shellcheck disable=SC1090,SC1091"
MAVEN_INSTALL_DIR="/opt/apache-maven-3.5.4"
MAVEN_LINK_DIR="/usr/local/apache-maven"
MAVEN_FILE="apache-maven-3.5.4-bin.tar.gz"
PROFILE_D_FILE="/etc/profile.d/apache-maven.sh"
cd /usr/local || exit 1
curl http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/\${MAVEN_FILE} -o /tmp/\${MAVEN_FILE}
sudo tar -xzf /tmp/\${MAVEN_FILE} -C \${MAVEN_INSTALL_DIR}
sudo rm -rf \${MAVEN_LINK_DIR}
sudo ln -f -s \${MAVEN_INSTALL_DIR} \${MAVEN_LINK_DIR}
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" | sudo tee \${PROFILE_D_FILE} >/dev/null
echo "export M2_HOME=\${MAVEN_LINK_DIR}" | sudo tee -a \${PROFILE_D_FILE} >/dev/null
echo "export MAVEN_HOME=\${MAVEN_LINK_DIR}" | sudo tee -a \${PROFILE_D_FILE} >/dev/null
echo "export PATH=\${MAVEN_LINK_DIR}/bin:\${PATH}" | sudo tee -a \${PROFILE_D_FILE} >/dev/null
# ${COMMENT}
. "\${PROFILE_D_FILE}"
mvn --version
EOF
chmod +x "\${INSTALL_MAVEN_SCRIPT}"
```
