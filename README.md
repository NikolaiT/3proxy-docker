## Using 3proxy in a Docker Container

[3Proxy](https://github.com/z3APA3A/3proxy) is an awesome proxy server implementation that allows you to do practically everything imaginable
when it comes to http/s socks4/5 proxy networking.

In this repository, we will use 3Proxy in an Alpine Linux Docker container for two different use cases:

1. 3Proxy running on any remote server as anonymous proxy. This is the classical use case. This allows clients (such as browsers or `curl`) to use the proxy server as a means to change it's IP address in order to become anonymous.
2. Another use case is to use 3Proxy as a local forwarding proxy. It forwards connections from one scheme to another scheme. For example, the Google Chrome browser does not support the `socks5://username:password@$1.2.3.4:8888` socks5 proxy format. But we can launch 3proxy locally as a proxy without username/password authentication and the forward the connection to a upstream proxy.

### Installation

Depending on the use case, you can do those commands either locally or on the remote server.

Clone this repository:

```
git clone https://github.com/NikolaiT/3proxy-docker
```

Then build the docker image with:

```
docker build -t 3proxy .
```

### Anonymous Proxy Server

On your favorite VPS server, run the Docker container with:

```
docker run -p 9799:9799 -p 8089:8089 --env PROXY_TYPE=anonymous 3proxy
```

Test that the proxy works by using `curl`. Let's assume your proxy server IP address is `1.2.3.4`.

```
curl -x socks5://test:testXX@$1.2.3.4:8089 -v http://httpbin.org/ip
```

### Local Forwarding Proxy

For the second use case, run the following command to get an local forwarding proxy:

```
docker run -p 9799:9799 --env PROXY_TYPE=forward 3proxy
```

Test that the proxy works by using `curl`.

```
curl -x http://0.0.0.0:9799 -v http://httpbin.org/ip
```

### Debug Commands

Kill the running Docker image process with

```
docker kill $(docker ps -q --filter ancestor=3proxy)
```

Connect into the container:

```
docker exec -it 3proxy /bin/bash
```

Get logging outputs of running docker image:

```
docker ps

docker exec -it c796f63d01d0 /bin/cat /var/log/3proxy/3proxy.log

docker exec -it c796f63d01d0 ls /var/log/3proxy/
```

