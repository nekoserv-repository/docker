FROM node:lts-alpine

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Flood-UI & custom conf"
LABEL website="https://github.com/TODO/docker-flood-ui"
LABEL version="1.0"

# init
ARG UID
ARG GID

# install stuff, get app & cleanup
RUN sed -i -e "s/^node:x:\([0-9]\+\):\([0-9]\+\)/node:x:2000:2000/g" /etc/passwd && \
    sed -i -e "s/^node.*/node:x:2000:node/g" /etc/group && \
    addgroup -g $GID flood && \
    adduser -S -u $UID -G flood flood && \
    apk add --no-cache curl tzdata unzip && \
    curl -L https://github.com/Flood-UI/flood/archive/master.zip -o flood.zip && \
    unzip -q flood.zip -d /home/flood && \
    chown -R flood:flood /home/flood && \
    rm flood.zip && \
    cd /home/flood/flood-master/ && \
    cp config.docker.js config.js && \
    sed -i -e "s/^  baseURI: .*/  baseURI: '\/flood\/',/g" config.js && \
    npm install && npm cache clean --force && \
    npm run build && \
    apk del --purge curl unzip

# drop privileges
USER flood

# volume for config, db & runtime stuff
VOLUME ["/home/flood/flood-master/data/"]

# run!
CMD [ "npm", "start", "--prefix", "/home/flood/flood-master" ]
