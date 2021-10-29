#!/bin/bash

echo 'Building 3proxy Dockerfile'

docker build -t 3proxy --build-arg PROXY_USERNAME=$PROXY_USERNAME --build-arg PROXY_PASSWORD=$PROXY_PASSWORD .