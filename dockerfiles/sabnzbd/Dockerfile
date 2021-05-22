FROM nekoserv/base-sabnzbd:0.4

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Debian + python3 + sabnzbd"
LABEL website="https://github.com/TODO/docker-sabnzbd"
LABEL version="1.2"

# init
ARG UID
ARG GID

# install stuff
RUN groupadd -g $UID sabnzbd && \
    useradd -g sabnzbd -u $GID sabnzbd && \
    mkdir -p /home/jackett/data/ && \
    mkdir -p /home/sabnzbd/config && \
    mkdir /home/sabnzbd/complete && \
    mkdir /home/postprocessing && \
    mkdir /home/incomplete && \
    apt-get update && apt-get install --no-install-recommends -y curl && \
    curl -L $(curl --silent "https://api.github.com/repos/sabnzbd/sabnzbd/releases/latest" \
      | grep '"tarball_url":' | sed -E 's/.*"([^"]+)".*/\1/') -o sabnzbd.tar.gz && \
    tar xzf sabnzbd.tar.gz -C /home/sabnzbd && \
    chown -R sabnzbd:sabnzbd /home/sabnzbd && \
    chown -R sabnzbd:sabnzbd /home/postprocessing && \
    mv /home/sabnzbd/sabnzbd* /home/sabnzbd/sabnzbd-release/ && \
    rm sabnzbd.tar.gz && \
    apt-get autoremove --purge -y curl && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# drop privileges
USER sabnzbd

# volume for config, db & runtime stuff
VOLUME ["/home/sabnzbd/config/"]
VOLUME ["/home/sabnzbd/complete/"]
VOLUME ["/home/postprocessing/"]
VOLUME ["/home/incomplete/"]

# run!
ENTRYPOINT ["python", "/home/sabnzbd/sabnzbd-release/SABnzbd.py", "--logging", "1", "--config-file", "/home/sabnzbd/config/"]
