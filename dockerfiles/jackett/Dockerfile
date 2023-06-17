FROM debian:12-slim

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Debian slim + jackett"
LABEL website="https://github.com/TODO/docker-jackett"
LABEL version="1.0"

# init
ARG UID
ARG GID
ENV XDG_CONFIG_HOME="/home/jackett/data"

# add group/user, then get app & cleanup
RUN groupadd -g $GID jackett && \
    useradd -m -g jackett -u $UID jackett && \
    mkdir /home/jackett/data/ && \
    apt-get update && apt-get install --no-install-recommends -y ca-certificates wget libicu72 && \
    export version=$(wget -qO- "https://api.github.com/repos/Jackett/Jackett/releases/latest" \
      | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    wget -nv --show-progress --progress=bar:force:noscroll https://github.com/Jackett/Jackett/releases/download/$version/Jackett.Binaries.LinuxAMDx64.tar.gz -O jackett.tar.gz && \
    tar xzf jackett.tar.gz -C /home/jackett && \
    chown -R jackett /home/jackett && \
    rm jackett.tar.gz && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# drop privileges
USER jackett

# volume for config, db & runtime stuff
VOLUME ["/home/jackett/data/"]

# run!
CMD ["/home/jackett/Jackett/jackett", "--NoUpdates"]
