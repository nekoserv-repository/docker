FROM python:3.8-alpine

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + python2 + medusa"
LABEL website="https://github.com/TODO/docker-medusa"
LABEL version="1.0"

# init
ARG UID
ARG GID

# install stuff, get app & cleanup
RUN addgroup -g $GID medusa && \
    adduser -S -u $UID -G medusa medusa && \
    apk add --no-cache curl tzdata unzip && \
    mkdir /home/medusa/data && \
    mkdir /home/postprocessing && \
    mkdir /home/medusa/dl && \
    curl -L https://github.com/pymedusa/Medusa/archive/master.zip -o medusa.zip && \
    unzip -q medusa.zip -d /home/medusa && \
    chown -R medusa:medusa /home/medusa && \
    chown -R medusa:medusa /home/postprocessing && \
    rm medusa.zip && \
    apk del --purge curl unzip

# drop privileges
USER medusa

# volume for config, db & runtime stuff
VOLUME ["/home/medusa/data"]
VOLUME ["/home/postprocessing"]

# run!
ENTRYPOINT ["/home/medusa/Medusa-master/SickBeard.py", "--datadir", "/home/medusa/data/"]
