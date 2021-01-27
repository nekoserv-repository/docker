FROM debian:10-slim

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Debian slim + Flood-UI"
LABEL website="https://github.com/TODO/docker-flood-ui"
LABEL version="1.0"

# init
ARG UID
ARG GID

# install stuff, get app & cleanup
RUN groupadd -g $UID flood && \
    useradd -m -g flood -u $GID flood && \
    echo "deb http://deb.debian.org/debian buster main" > /etc/apt/source.list && \
    apt-get update && apt-get install --no-install-recommends -y ca-certificates curl && \
    export version=$(curl --silent "https://api.github.com/repos/jesec/flood/releases/latest" \
      |  awk '/"tag_name":/ {print; exit;}' | sed -E 's/.*"v([^"]+)".*/\1/') && \
    curl -L https://github.com/jesec/flood/releases/download/v$version/flood-linux -o flood-linux && \
    mv flood-linux /home/flood/ && \
    chown -R flood:flood /home/flood && \
    chmod 0700 /home/flood/flood-linux && \
    apt-get autoremove --purge -y curl && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# drop privileges
USER flood

# run!
ENTRYPOINT ["/home/flood/flood-linux", "--host=0.0.0.0", "--rundir=/home/flood/data"]
