# install maven on debian

- [from here](https://tecadmin.net/install-apache-maven-on-debian/)

## **ATENTION** The default / standard package was to old

## install tar.gz from apache-mirror

```bash
MAVEN_INSTALL_SCRIPT="maven_install.sh"
cat <<EOF >"${MAVEN_INSTALL_SCRIPT}"
cd /usr/local
sudo wget http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
sudo tar xzf apache-maven-3.5.4-bin.tar.gz
sudo ln -s apache-maven-3.5.4 apache-maven
PROFILE_D_FILE="/etc/profile.d/apache-maven.sh"
sudo echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >\${PROFILE_D_FILE}
sudo echo "export M2_HOME=/usr/local/apache-maven" >>\${PROFILE_D_FILE}
sudo echo "export MAVEN_HOME=/usr/local/apache-maven" >>\${PROFILE_D_FILE}
sudo echo "export PATH=${M2_HOME}/bin:${PATH}" >>\${PROFILE_D_FILE}
EOF
chmod +x "${MAVEN_INSTALL_SCRIPT}"
```
