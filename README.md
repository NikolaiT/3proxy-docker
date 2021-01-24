## Using 3proxy in a Docker Container

3Proxy is an awesome proxy server that allows you to practically everything imaginable
when it comes to http/s socks4/5 proxy traffic routing.

In this repository, we will use 3Proxy in a Alpine Linux container for two different use cases:

1. 3Proxy running on a VPS server as anonymous proxy. This is the classical use case. This allows clients (such as browsers) to use the proxy server as a way to change it's IP address, in order to become anonymous.
2. Another use case is to use 3Proxy as a local forwarding proxy. It forwards connections from one scheme to another scheme on a upstream proxy.

### Anonymous Proxy Server

Build and run the image with

```
docker build -t 3proxy .
```

Run the image:

```
docker run -p 9799:9799 -p 8089:8089 --env PROXY_TYPE=anonymous 3proxy
```

Test that the proxy works with `curl`:

```
curl -x socks5://test:testXX@$IP:8089 -v http://httpbin.org/ip
```

### Local Forwarding Proxy

Run the local forwarding proxy:

```
docker run -p 9799:9799 --env PROXY_TYPE=forward 3proxy
```

### Debug Commands

Kill docker image process with

```
docker kill $(docker ps -q --filter ancestor=3proxy)
```

Connect into container:

```
docker exec -it 3proxy /bin/bash
```

Get log output of running docker image:

```
docker ps

docker exec -it c796f63d01d0 /bin/cat /var/log/3proxy/3proxy.log

docker exec -it c796f63d01d0 ls /var/log/3proxy/
```

