ARG NODE_IMAGE=node:lts-alpine
FROM ${NODE_IMAGE} as nodebuild

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Flood-UI & custom conf"
LABEL website="https://github.com/TODO/docker-flood-ui"
LABEL version="1.0"

# setup workdir
WORKDIR /usr/src/app/

# install stuff to build app
RUN apk add --no-cache curl && \
    curl -L https://api.github.com/repos/jesec/flood/tarball/master -o flood.tar.gz && \
    tar xzf flood.tar.gz --strip 1 && \
    apk del --purge curl && \
    npm set unsafe-perm true && npm install && \
    cp config.cli.js config.js && \
    npm run build && \
    npm pack --ignore-scripts

# now get the clean image
FROM ${NODE_IMAGE} as flood

# setup vars
ARG UID
ARG GID

# copy built package
COPY --from=nodebuild /usr/src/app/flood-*.tgz /tmp/flood.tgz

# install package and runtime dependencies
RUN apk add --no-cache mediainfo tzdata && \
    sed -i -e "s/^node:x:\([0-9]\+\):\([0-9]\+\)/node:x:2000:2000/g" /etc/passwd && \
    sed -i -e "s/^node.*/node:x:2000:node/g" /etc/group && \
    addgroup -g $GID flood && \
    adduser -S -u $UID -G flood flood && \
    chown flood:flood /tmp/flood.tgz

# drop privileges
USER flood

RUN npm config set prefix '/home/flood' && \
    npm install -g /tmp/flood.tgz && \
    rm /tmp/flood.tgz

# run!
ENTRYPOINT ["/home/flood/bin/flood", "--host=0.0.0.0", "--rundir=/data"]
