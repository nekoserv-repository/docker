FROM python:3.10-slim

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Debian slim + python3 + pyload-ng"
LABEL website="https://github.com/TODO/docker-pyload"
LABEL version="1.0"

# init
ARG UID
ARG GID

# install stuff, get app & cleanup
RUN addgroup -q --gid $UID pyload && \
    useradd -u $UID -g $GID pyload && \
    mkdir -p /home/pyload && \
    apt-get update && apt-get install --no-install-recommends -y curl libcurl4-openssl-dev gcc libc6-dev libssl-dev net-tools tini && \
    chown -R pyload:pyload /home/pyload && \
    pip install --pre pyload-ng[all] && \
    apt-get autoremove --purge -y libcurl4-openssl-dev gcc wget libc6-dev libssl-dev && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# drop privileges
USER pyload

# run!
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/pyload"]
