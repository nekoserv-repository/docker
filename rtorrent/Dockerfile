FROM python:3.12-alpine

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + python3 + rTorrent"
LABEL website="https://github.com/TODO/docker-rtorrent"
LABEL version="1.0"

# copy entrypoint
COPY docker-entrypoint.sh /usr/local/bin/

# install
RUN UID=1000 && GID=1000 && \
    addgroup -g $GID rtorrent && \
    adduser -S -u $UID -G rtorrent rtorrent && \
    apk add --no-cache rtorrent tzdata && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

# drop privileges
USER rtorrent

# run!
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
