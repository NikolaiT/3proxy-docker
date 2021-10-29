#!/bin/bash

PID=$(docker ps -q --filter ancestor=3proxy)

echo "Killing 3proxy docker instance PID=$PID"

docker kill $PID
