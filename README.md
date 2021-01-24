## How to run

build and run image

```
docker build -t 3proxy .

# daemonize
docker run -d -p 9799:9799 -p 8089:8089 3proxy

#normal
docker run -p 9799:9799 -p 8089:8089 3proxy
```

kill docker image process with

```
docker stop $(docker ps -q --filter ancestor=3proxy)
```

Test with:

```

IP=127.0.0.1

curl -x socks5://test:testXX@${IP}:8089 -v http://httpbin.org/ip

curl -x socks5://test:testXX@${IP}:8089 http://httpbin.org/ip

curl http://httpbin.org/ip
```

Connect into container:

```
docker exec -it 3proxy /bin/bash
```

Get log output:

```
docker ps

docker exec -it c796f63d01d0 /bin/cat /var/log/3proxy/3proxy.log

docker exec -it c796f63d01d0 ls /var/log/3proxy/
```

