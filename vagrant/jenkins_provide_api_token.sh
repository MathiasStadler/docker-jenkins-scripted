#!/bin/bash

# install dig
apt-get install -y dnsutils

# get ip from world wide web service e.g. google.com
wwwIp=$(dig +short google.com | tail -1)

# get the world wide interface
worldWideInterfaces=$(ip route get $(dig +short google.com | tail -1) | grep ${wwwIp} | awk '{print $5}')

# get the ip of worldwideinterfaces
worldWideIp=$(ip -f inet addr show "${worldWideInterfaces}" | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')

# which port used jenkins
# from here
# https://cloudvedas.com/solved-how-to-start-or-stop-jenkins-in-linux-and-check-its-port-number/
sudo lsof -i -P | grep -i jenkins

# user message
echo "try to reach jenkins on standard port  http://${worldWideIp}:8080"
echo "or"

# save BASH Internal Field Separator (IFS)
OLDIFS=$IFS
IFS=$('\n')

# get all port from jenkins
for i in $(sudo lsof -i -P | grep -i jenkins | grep LISTEN); do
	port=$(echo "$i" | awk '{print $9 }' | cut -d ':' -f2)
	# output of alternative port
	echo "try to reach jenkins http://${worldWideIp}:$port"
done

# restore BASH Internal Field Separator (IFS)
IFS=$OLDIFS
