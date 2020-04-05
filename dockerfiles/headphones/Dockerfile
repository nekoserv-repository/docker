FROM python:2-alpine3.11

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + python2 + headphones"
LABEL website="https://github.com/TODO/docker-headphones"
LABEL version="1.0"

# init
ARG UID
ARG GID

# install stuff, get app & cleanup
RUN addgroup -g $GID headphones && \
    adduser -S -u $UID -G headphones headphones && \
    apk add --no-cache curl tzdata && \
    mkdir /home/headphones/data && \
    mkdir /home/postprocessing && \
    mkdir /home/headphones/dl && \
    curl -L https://github.com/rembo10/headphones/tarball/master -o headphones.tar.gz && \
    tar xzf headphones.tar.gz -C /home/headphones && \
    mv /home/headphones/*headphones* /home/headphones/headphones-release/ && \
    export sha=$(curl --silent "https://api.github.com/repos/rembo10/headphones/commits/master" \
      | grep -m1 '"sha":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    echo $sha > /home/headphones/headphones-release/version.txt && \
    chown -R headphones:headphones /home/headphones && \
    chown -R headphones:headphones /home/postprocessing && \
    rm headphones.tar.gz && \
    apk del --purge curl

# drop privileges
USER headphones

# volume for config, db & runtime stuff
VOLUME ["/home/headphones/data"]
VOLUME ["/home/postprocessing"]

# run!
ENTRYPOINT ["/home/headphones/headphones-release/Headphones.py", "--datadir", "/home/headphones/data/", "--nolaunch", "-v"]
