FROM alpine:3.12

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine & darkhttpd & homer"
LABEL website="https://github.com/TODO/docker-homer"
LABEL version="1.0"

# init
ARG UID
ARG GID
ARG OVERRIDE

# install
RUN [[ -z "$UID" ]] && UID=$(( $RANDOM % 9000 + 1000 )) || UID=$UID && \
    [[ -z "$GID" ]] && GID=$(( $RANDOM % 9000 + 1000 )) || GID=$UID && \
    addgroup -g $GID homepage && \
    adduser -S -u $UID -G homepage homepage && \
    mkdir -p /home/homepage/www/ && \
    apk add --no-cache curl darkhttpd tzdata unzip && \
    export version=$(curl --silent "https://api.github.com/repos/bastienwirtz/homer/releases/latest" \
      | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    curl -L https://github.com/bastienwirtz/homer/releases/download/$version/homer.zip -o homepage.zip && \
    unzip -q homepage.zip -d /home/homepage/www && \
    [[ ! -z "$OVERRIDE" ]] && sed -i -e 's/\/title>/\/title><script defer src="js\/override.js"><\/script>/g' /home/homepage/www/index.html || true && \
    chown -R $UID:$GID /home/homepage && \
    rm homepage.zip && \
    apk del --purge curl unzip
    

# drop privileges
USER homepage

# static volume
VOLUME ["/home/homepage/www/assets/config.yml"]

# run!
ENTRYPOINT ["darkhttpd", "/home/homepage/www", "--port", "18083", "--no-listing"]
