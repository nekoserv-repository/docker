FROM alpine:3.20

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + radarr"
LABEL website="https://github.com/TODO/docker-radarr"
LABEL version="1.0"

# init
ENV XDG_CONFIG_HOME="/home/radarr/data"

# add group/user, then get app & cleanup
RUN UID=1000 && GID=1000 && \
    addgroup -g $GID radarr && \
    adduser -S -u $UID -G radarr radarr && \
    apk add --no-cache curl mediainfo tzdata icu-libs libintl sqlite-libs && \
    mkdir -p /home/radarr/data/ && \
    export version=$(curl --silent "https://api.github.com/repos/Radarr/Radarr/releases/latest" \
      |  awk '/"tag_name":/ {print; exit;}' | sed -E 's/.*"v([^"]+)".*/\1/') && \
    curl -L https://github.com/Radarr/Radarr/releases/download/v$version/Radarr.master.$version.linux-musl-core-x64.tar.gz -o radarr.tar.gz && \
    tar xzf radarr.tar.gz -C /home/radarr && \
    chown -R radarr /home/radarr && \
    rm radarr.tar.gz && \
    apk del --purge curl

# drop privileges
USER radarr

# run!
CMD ["/home/radarr/Radarr/Radarr", "-nobrowser"]
