FROM python:3.11-alpine

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + python3 + medusa"
LABEL website="https://github.com/TODO/docker-medusa"
LABEL version="1.0"

# install stuff, get app & cleanup
RUN UID=1000 && GID=1000 && \
    addgroup -g $GID medusa && \
    adduser -S -u $UID -G medusa medusa && \
    apk add --no-cache curl mediainfo tzdata && \
    mkdir /home/medusa/app && \
    export version=$(curl --silent "https://api.github.com/repos/pymedusa/medusa/releases/latest" \
      |  awk '/"tag_name":/ {print; exit;}' | sed -E 's/.*"v([^"]+)".*/\1/') && \
    curl -L https://github.com/pymedusa/Medusa/archive/v$version.tar.gz -o medusa.tar.gz && \
    tar xzf medusa.tar.gz --strip 1 -C /home/medusa/app && \
    chown -R medusa:medusa /home/medusa && \
    rm medusa.tar.gz && \
    apk del --purge curl

# drop privileges
USER medusa

# volume for config, db & runtime stuff
VOLUME ["/home/medusa/data"]
VOLUME ["/home/postprocessing"]

# run!
ENTRYPOINT ["/home/medusa/app/SickBeard.py", "--datadir", "/home/medusa/data/"]
