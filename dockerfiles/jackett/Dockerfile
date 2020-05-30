FROM mono:6

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + mono + jackett"
LABEL website="https://github.com/TODO/docker-jackett"
LABEL version="1.0"

# init
ARG UID
ARG GID
ENV XDG_CONFIG_HOME="/home/jackett/data"

# add group/user, then get app & cleanup
RUN groupadd -g $GID jackett && \
    useradd -g jackett -u $UID jackett && \
    mkdir -p /home/jackett/data/ && \
    export version=$(curl --silent "https://api.github.com/repos/Jackett/Jackett/releases/latest" \
      | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | awk '{print(substr($1,2))}') && \
    curl -L https://github.com/Jackett/Jackett/releases/download/v$version/Jackett.Binaries.LinuxAMDx64.tar.gz -o jackett.tar.gz && \
    tar xzf jackett.tar.gz -C /home/jackett && \
    chown -R jackett /home/jackett && \
    rm jackett.tar.gz && \
    apt-get autoremove --purge -y curl && \
    rm -rf /var/lib/apt/lists/* /tmp/*
    

# drop privileges
USER jackett

# volume for config, db & runtime stuff
VOLUME ["/home/jackett/data/"]

# run!
CMD ["/home/jackett/Jackett/jackett", "--NoUpdates"]
