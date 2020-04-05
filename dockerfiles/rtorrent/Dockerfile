FROM python:3.8-alpine

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + python2 + rTorrent"
LABEL website="https://github.com/TODO/docker-rtorrent"
LABEL version="1.0"

# init
ARG UID
ARG GID

# copy entrypoint
COPY docker-entrypoint.sh /usr/local/bin/

# install
# using @edge for fixed xmlrpc-c release (no flood!)
RUN addgroup -g $GID rtorrent && \
    adduser -S -u $UID -G rtorrent rtorrent && \
    ##echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    ##apk add --no-cache rtorrent xmlrpc-c@edge tzdata && \
    #sed -i -e 's/3.10/3.11/g' /etc/apk/repositories && \
    apk add --no-cache rtorrent tzdata && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

# drop privileges
USER rtorrent

# volume for rtorrent data
VOLUME ["/home/rtorrent/"]

# run!
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
