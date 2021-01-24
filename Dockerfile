FROM alpine:latest

ARG VERSION=0.9.3

RUN apk add --update alpine-sdk wget bash && \
    cd / && \
    wget -q  https://github.com/z3APA3A/3proxy/releases/download/${VERSION}/3proxy-${VERSION}.tar.gz && \
    tar xzf 3proxy-${VERSION}.tar.gz && \
    cd 3proxy-${VERSION} && \
    make -f Makefile.Linux

# create 3proxy config dir
RUN mkdir /etc/3proxy/

# for storing logfiles
RUN mkdir /var/log/3proxy/

# copy binary
RUN mv 3proxy-${VERSION}/bin/3proxy /etc/3proxy/
RUN chmod +x /etc/3proxy/3proxy

# copy configuration files
COPY 3proxy.cfg /etc/3proxy/
COPY .proxyauth /etc/3proxy/

# add dumb-init
# RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.4/dumb-init_1.2.4_x86_64
# RUN chmod +x /usr/local/bin/dumb-init

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]