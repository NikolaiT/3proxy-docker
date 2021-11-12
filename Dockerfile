# check new stuff here: https://github.com/rb-dock8s/3proxy/blob/master/Dockerfile

FROM alpine:latest

# `anonymous` run a anonymous proxy server that clients can connect to
# `forward` run a local proxy server that forwards connections to a upstream proxy
ENV PROXY_TYPE=anonymous

# The version of 3proxy
ARG VERSION=0.9.4

RUN apk add --update alpine-sdk wget bash git && \
    cd / && \
    git clone https://github.com/3proxy/3proxy && \
    cd 3proxy && ln -s Makefile.Linux Makefile && \
    make && make install

# proxy creds
ARG PROXY_USERNAME=test
ARG PROXY_PASSWORD=kvi42VVs74

RUN /etc/3proxy/conf/add3proxyuser.sh $PROXY_USERNAME $PROXY_PASSWORD

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 1080:1080/tcp 3128:3128/tcp

ENTRYPOINT ["/entrypoint.sh"]