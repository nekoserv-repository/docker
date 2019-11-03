FROM nekoserv/base-couchpotato:0.1

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld
LABEL description="Alpine + python2 + CouchPotato"
LABEL website="https://github.com/TODO/docker-couchpotato"
LABEL version="1.0"

# init
ARG UID
ARG GID
ENV UID=$UID
ENV GID=$GID

# install stuff
RUN addgroup -g $GID couchpotato && \
    adduser -S -u $UID -G couchpotato couchpotato && \
    apk add --no-cache curl && \
    mkdir /home/couchpotato/data && \
    mkdir /home/postprocessing && \
    mkdir /home/couchpotato/dl && \
    curl -L https://github.com/CouchPotato/CouchPotatoServer/archive/master.zip -o couchpotato.zip && \
    unzip -q couchpotato.zip -d /home/couchpotato && \
    chown -R couchpotato:couchpotato /home/couchpotato && \
    chown -R couchpotato:couchpotato /home/postprocessing && \
    rm couchpotato.zip && \
    apk del --purge curl

# drop privileges
USER couchpotato

# volume for config, db & runtime stuff
VOLUME ["/home/couchpotato/data"]
VOLUME ["/home/postprocessing"]

# run!
ENTRYPOINT ["/home/couchpotato/CouchPotatoServer-master/CouchPotato.py", "--data_dir", "/home/couchpotato/data/", "--console_log"]
