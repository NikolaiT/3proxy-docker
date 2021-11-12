#!/bin/bash

# Builds and installs 3proxy on Ubuntu 20.04 LTS

# Obviously change this
USER=test
PASS=kd93Vsk9HbjS
ADMIN_PASS=7fkBHkssUywnl

# Install required libraries
sudo apt-get -y update
sudo apt-get -y install build-essential gcc git
sudo apt-get -y install net-tools

# Install latest 3proxy from source
echo 'Installing 3proxy from source'

git clone https://github.com/z3apa3a/3proxy

cd 3proxy

ln -s Makefile.Linux Makefile

make

sudo make install

sleep 1

# adding proxy users
chmod +x /etc/3proxy/conf/add3proxyuser.sh
/etc/3proxy/conf/add3proxyuser.sh $USER $PASS
/usr/local/3proxy/conf/add3proxyuser.sh admin $ADMIN_PASS

# start the proxy server
systemctl start 3proxy.service

# print proxy usage
IPS=($(hostname -I))
IP=${IPS[idx]}
echo "Use 3proxy as follows"
echo "curl -x socks5h://$USER:$PASS@$IP:1080 https://httpbin.org/ip"
echo "curl -x http://$USER:$PASS@$IP:3128 https://httpbin.org/ip"

# just in case
systemctl reload 3proxy.service

# show proxy logging
tail -f -n50 /var/log/3proxy/*