FROM alpine:3.14

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + Flood-UI"
LABEL website="https://github.com/TODO/docker-flood-ui"
LABEL version="1.0"

# init
ARG UID
ARG GID

# install stuff, get app & cleanup
RUN addgroup -g $GID flood && \
    adduser -S -u $UID -G flood flood && \
    apk add --no-cache curl mediainfo tzdata && \
    export version=$(curl --silent "https://api.github.com/repos/jesec/flood/releases/latest" \
      |  awk '/"tag_name":/ {print; exit;}' | sed -E 's/.*"v([^"]+)".*/\1/') && \
    curl -L https://github.com/jesec/flood/releases/download/v$version/flood-linux-x64 -o /home/flood/flood-linux && \
    chown flood:flood /home/flood/flood-linux && \
    chmod 0700 /home/flood/flood-linux && \
    apk del --purge curl

# drop privileges
USER flood

# run!
ENTRYPOINT ["/home/flood/flood-linux"]
