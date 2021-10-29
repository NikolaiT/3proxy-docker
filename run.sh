#!/bin/bash

echo 'Running 3proxy Dockerfile'

docker run -p 9799:9799 -p 8089:8089 --env PROXY_TYPE=anonymous 3proxy