FROM python:3.12-alpine

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + sabnzbd"
LABEL website="https://github.com/TODO/docker-sabnzbd"
LABEL version="1.3"

# install stuff
RUN UID=1000 && GID=1000 && \
    addgroup -g $GID sabnzbd && \
    adduser -S -u $UID -G sabnzbd sabnzbd && \
    mkdir /home/sabnzbd/sabnzbd-release && \
    mkdir /home/sabnzbd/config && \
    mkdir /home/sabnzbd/complete && \
    mkdir /home/postprocessing && \
    mkdir /home/incomplete && \
    # \
    ## install tools \
    # \
    echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache curl 7zip libarchive-tools unzip uv@edge xz && \
    # \
    ## pip dependencies \
    # \
    curl https://raw.githubusercontent.com/sabnzbd/sabnzbd/master/requirements.txt -o /tmp/sabnzbd-requirements.txt && \
    uv pip install --break-system-packages --system -r /tmp/sabnzbd-requirements.txt && \
    rm /tmp/sabnzbd-requirements.txt && \
    # \
    ## get release \
    # \
    curl -L $(curl --silent "https://api.github.com/repos/sabnzbd/sabnzbd/releases/latest" \
      | grep '"tarball_url":' | sed -E 's/.*"([^"]+)".*/\1/') -o sabnzbd.tar.gz && \
    tar xzf sabnzbd.tar.gz --strip 1 -C /home/sabnzbd/sabnzbd-release/ && \
    chown -R sabnzbd:sabnzbd /home/sabnzbd && \
    rm sabnzbd.tar.gz && \
    # \
    ## par2cmdline-turbo \
    # \
    export version=$(curl --silent "https://api.github.com/repos/animetosho/par2cmdline-turbo/releases/latest" \
      |  awk '/"tag_name":/ {print; exit;}' | sed -E 's/.*"v([^"]+)".*/\1/') && \
    curl -L https://github.com/animetosho/par2cmdline-turbo/releases/download/v$version/par2cmdline-turbo-v$version-linux-amd64.xz -o par2cmdline-turbo.xz && \
    unxz -d par2cmdline-turbo.xz && \
    mv par2cmdline-turbo /usr/local/bin/par2 && \
    chmod 0700 /usr/local/bin/par2 && \
    chown sabnzbd:sabnzbd /usr/local/bin/par2 && \
    # \
    ## unrar \
    # \
    wget -q https://github.com/nekoserv-repository/packages/raw/refs/heads/main/alpinelinux/unrar/unrar && \
    wget -q https://github.com/nekoserv-repository/packages/raw/refs/heads/main/alpinelinux/unrar/unrar.md5 && \
    md5sum -c unrar.md5 && rm unrar.md5 && mv unrar /usr/local/bin/ && \
    chmod 0700 /usr/local/bin/unrar && \
    chown sabnzbd:sabnzbd /usr/local/bin/unrar && \    
    # \
    ## clean \
    # \
    apk del --purge curl uv xz && \
    rm -rf /var/cache/apk/* ~/.cache/*

# drop privileges
USER sabnzbd

# run!
ENTRYPOINT ["python", "/home/sabnzbd/sabnzbd-release/SABnzbd.py", "--logging", "1", "--config-file", "/home/sabnzbd/config/"]
