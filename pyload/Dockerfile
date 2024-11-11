FROM python:3.12-alpine

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + pyload-ng"
LABEL website="https://github.com/TODO/docker-pyload"
LABEL version="1.0"

# install stuff, get app & cleanup
RUN UID=1000 && GID=1000 && \
    addgroup -g $GID pyload && \
    adduser -S -u $UID -G pyload pyload && \
    mkdir -p /home/pyload && \
    chown -R pyload:pyload /home/pyload && \
    echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache curl-dev gcc libcurl musl-dev py3-pip python3-dev uv@edge tini tzdata && \
    uv pip install --break-system-packages --system --pre pyload-ng[all] && \
    apk del --purge curl-dev gcc musl-dev py3-pip python3-dev uv && \
    rm -rf /var/cache/apk/* ~/.cache/*

# drop privileges
USER pyload

# run!
ENTRYPOINT ["/sbin/tini", "--", "pyload"]
