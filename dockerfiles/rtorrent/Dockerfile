FROM python:3.8-alpine

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + python3 + rTorrent"
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
    apk add --no-cache rtorrent tzdata && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

# drop privileges
USER rtorrent

# volume for rtorrent data
VOLUME ["/home/rtorrent/"]

# run!
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
