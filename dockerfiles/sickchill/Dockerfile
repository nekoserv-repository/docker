FROM python:2-alpine3.10

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld
LABEL description="Alpine + python2 + SickChill"
LABEL website="https://github.com/TODO/docker-sickchill"
LABEL version="1.0"

# init
ARG UID
ARG GID
ENV UID=$UID
ENV GID=$GID

# install stuff, get app & cleanup
RUN addgroup -g $GID sickchill && \
    adduser -S -u $UID -G sickchill sickchill && \
    apk add --no-cache curl libxslt tzdata unzip && \
    mkdir /home/sickchill/data && \
    mkdir /home/postprocessing && \
    mkdir /home/sickchill/dl && \
    curl -L https://github.com/SickChill/SickChill/archive/master.zip -o sickchill.zip && \
    unzip -q sickchill.zip -d /home/sickchill && \
    chown -R sickchill:sickchill /home/sickchill && \
    chown -R sickchill:sickchill /home/postprocessing && \
    rm sickchill.zip && \
    apk del --purge curl unzip

# drop privileges
USER sickchill

# volume for config, db & runtime stuff
VOLUME ["/home/sickchill/data"]
VOLUME ["/home/postprocessing"]

# run!
ENTRYPOINT ["/home/sickchill/SickChill-master/SickBeard.py", "--datadir", "/home/sickchill/data/"]
