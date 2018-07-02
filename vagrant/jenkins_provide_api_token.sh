#!/bin/bash

# install dig and hxselect
# from here
# https://askubuntu.com/questions/258219/how-do-i-make-apt-get-install-less-noisy
# last entry
sudo apt install -y -qq -o=Dpkg::Use-Pty=0 dnsutils html-xml-utils

# get the ip of worldwideinterfaces
# vm.bridge.ip would be provide from found-bridge-adapter.sh script
worldWideIp=$(cat /home/vagrant/vm.bridge.ip)

# which port used jenkins
# from here
# https://cloudvedas.com/solved-how-to-start-or-stop-jenkins-in-linux-and-check-its-port-number/
# sudo lsof -i -P | grep -i jenkins

# user message
echo "try to reach jenkins on STANDARD port  http://${worldWideIp}:8080"
echo "or"

# save BASH Internal Field Separator (IFS)
OLDIFS=$IFS
IFS=$'\n'

# get all port from jenkins
for i in $(sudo lsof -i -P | grep -i jenkins | grep LISTEN); do
	port=$(echo "$i" | awk '{print $9 }' | cut -d ':' -f2)
	# output of alternative port
	echo "try to reach jenkins http://${worldWideIp}:$port"
done

# restore BASH Internal Field Separator (IFS)
IFS=$OLDIFS

# get Jenkins API token
# from here
# https://stackoverflow.com/questions/36633725/generate-jenkins-api-token-using-rest-api?rq=1
curl --silent --basic http://admin:admin@${worldWideIp}:8080/me/configure | hxselect '#apiToken' | sed 's/.*value="\([^"]*\)".*/\1\n/g'
