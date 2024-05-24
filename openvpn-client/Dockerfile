FROM alpine:3.20

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + OpenVPN client"
LABEL website="https://github.com/TODO/docker-openvpn-client"
LABEL version="1.0"

# copy shell file
COPY docker-entrypoint.sh /usr/local/sbin/

# openvpn install & clean
RUN apk add --no-cache drill nftables openvpn tini tzdata && \
    chmod 0700 /usr/local/sbin/docker-entrypoint.sh

# RUN, BABY, RUN
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/sbin/docker-entrypoint.sh"]
