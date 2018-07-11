# install eclipse on debian

```bash
INSTALL_ECLIPSE_SCRIPT="install-eclipse.sh"
cat <<EOF >"${INSTALL_ECLIPSE_SCRIPT}"
#!/bin/bash
cd /tmp
wget http://ftp.fau.de/eclipse/technology/epp/downloads/release/oxygen/2/eclipse-jee-oxygen-2-linux-gtk-x86_64.tar.gz
sudo tar xfz eclipse-jee-oxygen-2-linux-gtk-x86_64.tar.gz -C /opt/
EOF
chmod +x ${INSTALL_ECLIPSE_SCRIPT}
```
