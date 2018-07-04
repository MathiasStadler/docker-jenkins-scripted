# ngrep

## install

```bash
sudo apt-get install -y  ngrep
```

## captured http request

```bash
sudo ngrep -q -d eth1 -W byline host 192.168.178.96 and port 8080
#
sudo ngrep -q -d eth1 -W byline host $(cat ~/vm.bridge.ip) and port 8080
```
