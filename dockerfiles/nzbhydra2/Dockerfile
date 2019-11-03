FROM adoptopenjdk/openjdk11-openj9:jre11u-alpine-nightly

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld
LABEL description="Alpine + openjdk11 + NZBHydra2"
LABEL website="https://github.com/TODO/docker-nzbhydra2"
LABEL version="1.0"

# init
ARG UID
ARG GID
ENV UID=$UID
ENV GID=$GID

# add group/user, then get app & cleanup
RUN addgroup -g $GID nzbhydra2 && \
    adduser -S -u $UID -G nzbhydra2 nzbhydra2 && \
    mkdir /home/nzbhydra2/data/ && \
    apk add --no-cache curl unzip && \
    export version=$(curl --silent "https://api.github.com/repos/theotherp/nzbhydra2/releases/latest" \
      | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | awk '{print(substr($1,2))}') && \
    curl -L https://github.com/theotherp/nzbhydra2/releases/download/v$version/nzbhydra2-$version-linux.zip -o nzbhydra2.zip && \
    unzip -q nzbhydra2.zip -d /home/nzbhydra2 && \
    chown -R nzbhydra2 /home/nzbhydra2 && \
    chmod +x /home/nzbhydra2/nzbhydra2 && \
    rm nzbhydra2.zip && \
    apk del --purge curl unzip

# drop privileges
USER nzbhydra2

# volume for config, db & runtime stuff
VOLUME ["/home/nzbhydra2/data/"]

# run!
CMD ["/home/nzbhydra2/nzbhydra2", "--datafolder", "/home/nzbhydra2/data/"]
