#!/bin/bash

echo 'Testing socks 3proxy'

curl -x "socks4a://$PROXY_USERNAME:$PROXY_PASSWORD@0.0.0.0:8089" "http://httpbin.org/ip"

echo 'Testing http 3proxy'

curl -x "http://$PROXY_USERNAME:$PROXY_PASSWORD@0.0.0.0:9799" "http://httpbin.org/ip"