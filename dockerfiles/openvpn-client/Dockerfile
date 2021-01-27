FROM alpine:3.13

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + OpenVPN client"
LABEL website="https://github.com/TODO/docker-openvpn-client"
LABEL version="1.0"

# copy entrypoint
COPY docker-entrypoint.sh /usr/local/bin/

# openvpn install & clean [ TODO : add gosu! ]
RUN apk add --no-cache nftables openvpn tini tzdata && \
    chmod u+x /usr/local/bin/docker-entrypoint.sh

# mount config file
VOLUME ["/openvpn-config"]

# RUN, BABY, RUN
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/docker-entrypoint.sh"]
