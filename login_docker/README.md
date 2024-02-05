## Bug
New Visual Studio Code requires Ubuntu>=20.04 can not log in Ubuntu 18.04 on 101-ICT.

## Solution

I write a Dockerfile to solve it.


### Build the docker
```shell
docker build -t login_docker:latest .
```

### Start docker
```shell
docker run -p 2222:22 -t -d --gpus all login_docker:latest
```

### In docker start ssh server
```shell
su root
service ssh start
```

### Then we connect thought ssh

ssh config:

```shell
Host dss-docker
  HostName 129.11.28.80
  User xiachunwei
  Port 2222
```
