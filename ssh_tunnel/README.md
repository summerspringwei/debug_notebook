
## Use SSH tunnel to expose http service

We have a http service on machine A with private ip address and want to expose this service through a machine B with public ip address.

First we need to make sure we can ssh from A to B;
Secondly on machine B, in the sshd_config file set `AllowAgentForwarding yes`,  `AllowTcpForwarding yes`
and `GatewayPorts yes`. 
then execute the following on machine A:
```shell
ssh -N -R machine-b-public-ip:port:localhost:port user@machine-b-public-ip
```
for example:
```shell
ssh -N -R 8.141.164.33:8080:localhost:9001 root@8.141.164.33
```

We can start a simple http server on machine A to test:
```shell
python -m http.server 9001
```

Then make sure the firewall on machine B is properly set.
```shell
sudo ufw status
sudo ufw allow 8080/tcp
```

On ali cloud, use `firewall-cmd`:
```shell
sudo systemctl start firewalld
sudo systemctl disable firewalld
sudo firewall-cmd --state
sudo firewall-cmd --get-default-zone
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --zone=public --add-port=53/udp --permanent
```

Then can test the on a local computer:
```shell
curl machine-b-public-ip:port
```