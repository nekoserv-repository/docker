FROM mono:6

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + mono + radarr"
LABEL website="https://github.com/TODO/docker-radarr"
LABEL version="1.0"

# init
ARG UID
ARG GID
ENV XDG_CONFIG_HOME="/home/radarr/data"

# add group/user, then get app & cleanup
RUN groupadd -g $GID radarr && \
    useradd -g radarr -u $UID radarr && \
    mkdir -p /home/radarr/data/ && \
    export version=$(curl --silent "https://api.github.com/repos/Radarr/Radarr/releases" \
      |  awk '/"tag_name":/ {print; exit;}' | sed -E 's/.*"v([^"]+)".*/\1/') && \
    curl -L https://github.com/Radarr/Radarr/releases/download/v$version/Radarr.develop.$version.linux.tar.gz -o radarr.tar.gz && \
    tar xzf radarr.tar.gz -C /home/radarr && \
    chown -R radarr /home/radarr && \
    rm radarr.tar.gz && \
    apt-get autoremove --purge -y curl && \
    apt-get update && apt-get install --no-install-recommends -y mediainfo && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# drop privileges
USER radarr

# volume for config, db & runtime stuff
VOLUME ["/home/radarr/data/"]

# run!
CMD ["/usr/bin/mono", "/home/radarr/Radarr/Radarr.exe", "-nobrowser"]
