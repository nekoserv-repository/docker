FROM adoptopenjdk/openjdk15-openj9:alpine-jre

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + jre15 + NZBHydra2"
LABEL website="https://github.com/TODO/docker-nzbhydra2"
LABEL version="1.0"

# init
ARG UID
ARG GID

# add group/user, then get app & cleanup
RUN addgroup -g $GID nzbhydra2 && \
    adduser -S -u $UID -G nzbhydra2 nzbhydra2 && \
    mkdir /home/nzbhydra2/data/ && \
    apk add --no-cache curl tzdata unzip && \
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
ENTRYPOINT ["/home/nzbhydra2/nzbhydra2", "--datafolder", "/home/nzbhydra2/data/"]
