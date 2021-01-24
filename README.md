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
docker stop 3proxy
```

Test with:

```
curl -socks5 test:testXX@0.0.0.0:8089 http://httpbin.org/ip
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

