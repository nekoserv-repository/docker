FROM mono:6

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + mono + lidarr"
LABEL website="https://github.com/TODO/docker-lidarr"
LABEL version="1.0"

# init
ARG UID
ARG GID
ENV XDG_CONFIG_HOME="/home/lidarr/data"

# add group/user, then get app & cleanup
RUN groupadd -g $GID lidarr && \
    useradd -g lidarr -u $UID lidarr && \
    mkdir -p /home/lidarr/data/ && \
    export version=$(curl --silent "https://api.github.com/repos/lidarr/Lidarr/releases" \
      |  awk '/"tag_name":/ {print; exit;}' | sed -E 's/.*"v([^"]+)".*/\1/') && \
    curl -L https://github.com/lidarr/lidarr/releases/download/v$version/Lidarr.master.$version.linux.tar.gz -o lidarr.tar.gz && \
    tar xzf lidarr.tar.gz -C /home/lidarr && \
    chown -R lidarr /home/lidarr && \
    rm lidarr.tar.gz && \
    apt-get autoremove --purge -y curl && \
    apt-get update && apt-get install --no-install-recommends -y libchromaprint-tools && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# drop privileges
USER lidarr

# volume for config, db & runtime stuff
VOLUME ["/home/lidarr/data/"]

# run!
CMD ["/usr/bin/mono", "/home/lidarr/Lidarr/Lidarr.exe", "-nobrowser"]
