FROM alpine:3.19

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + aria2"
LABEL website="https://github.com/TODO/docker-aria2"
LABEL version="1.0"

# install
RUN UID=1000 && GID=1000 && \
    addgroup -g $GID aria2 && \
    adduser -S -u $UID -G aria2 aria2 && \
    apk add --no-cache aria2 tzdata

# drop privileges
USER aria2

# volume for aria2 data
VOLUME ["/home/aria2/dl/"]

# run!
ENTRYPOINT ["/usr/bin/aria2c", "--conf-path=/etc/aria2.conf"]
