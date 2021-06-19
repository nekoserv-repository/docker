FROM alpine:3.14

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + lidarr"
LABEL website="https://github.com/TODO/docker-lidarr"
LABEL version="1.0"

# init
ARG UID
ARG GID
ENV XDG_CONFIG_HOME="/home/lidarr/data"

# add group/user, then get app & cleanup
RUN addgroup -g $GID lidarr && \
    adduser -S -u $UID -G lidarr lidarr && \
    apk add --no-cache curl chromaprint tzdata icu-libs libintl sqlite-libs && \
    mkdir -p /home/lidarr/data/ && \
    export version=$(curl --silent "https://api.github.com/repos/lidarr/Lidarr/releases" \
      |  awk '/"tag_name":/ {print; exit;}' | sed -E 's/.*"v([^"]+)".*/\1/') && \
    curl -L https://github.com/lidarr/Lidarr/releases/download/v$version/Lidarr.master.$version.linux-musl-core-x64.tar.gz -o lidarr.tar.gz && \
    tar xzf lidarr.tar.gz -C /home/lidarr && \
    chown -R lidarr /home/lidarr && \
    rm lidarr.tar.gz && \
    apk del --purge curl

# drop privileges
USER lidarr

# volume for config, db & runtime stuff
VOLUME ["/home/lidarr/data/"]

# run!
CMD ["/home/lidarr/Lidarr/Lidarr", "-nobrowser"]
