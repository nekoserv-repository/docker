FROM nekoserv/base-sabnzbd:0.1

# Dokerfile's infos
LABEL maintainer="Yuu" mail="yuu@fai.tld"
LABEL description="Alpine + python2 + sabnzbd"
LABEL website="https://github.com/TODO/docker-sabnzbd"
LABEL version="1.0"

# init
ARG UID
ARG GID
ENV UID=$UID
ENV GID=$GID

# install stuff
RUN addgroup -g $GID sabnzbd && \
    adduser -S -u $UID -G sabnzbd sabnzbd && \
    mkdir /home/sabnzbd/config && \
    mkdir /home/sabnzbd/complete && \
    mkdir /home/postprocessing && \
    mkdir /home/incomplete && \
    apk add --no-cache curl && \
    curl -L $(curl --silent "https://api.github.com/repos/sabnzbd/sabnzbd/releases/latest" \
      | grep '"tarball_url":' | sed -E 's/.*"([^"]+)".*/\1/') -o sabnzbd.tar.gz && \
    tar xzf sabnzbd.tar.gz -C /home/sabnzbd && \
    chown -R sabnzbd:sabnzbd /home/sabnzbd && \
    chown -R sabnzbd:sabnzbd /home/postprocessing && \
    mv /home/sabnzbd/sabnzbd* /home/sabnzbd/sabnzbd-release/ && \
    rm sabnzbd.tar.gz && \
    apk del --purge curl

# drop privileges
USER sabnzbd

# volume for config, db & runtime stuff
VOLUME ["/home/sabnzbd/config/"]
VOLUME ["/home/sabnzbd/complete/"]
VOLUME ["/home/postprocessing/"]
VOLUME ["/home/incomplete/"]

# run!
ENTRYPOINT ["python", "-OO", "/home/sabnzbd/sabnzbd-release/SABnzbd.py", "--config-file", "/home/sabnzbd/config/"]
