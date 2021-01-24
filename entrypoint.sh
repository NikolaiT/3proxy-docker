#!/bin/bash

if [[ $PROXY_TYPE = "anonymous" ]]
then
    CONFIG_FILE=/etc/3proxy/3proxy.cfg
else
    CONFIG_FILE=/etc/3proxy/3proxy-forward-chain.cfg
fi

echo "Starting $PROXY_TYPE 3proxy server."

# Run 3proxy
/etc/3proxy/3proxy /etc/3proxy/3proxy.cfg