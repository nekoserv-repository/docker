FROM alpine:3.15

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine & nginx & homer"
LABEL website="https://github.com/TODO/docker-homer"
LABEL version="1.0"

# init
ARG UID
ARG GID

# copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# install
RUN [[ -z "$UID" ]] && UID=$(( $RANDOM % 9000 + 1000 )) || UID=$UID && \
    [[ -z "$GID" ]] && GID=$(( $RANDOM % 9000 + 1000 )) || GID=$UID && \
    addgroup -g $GID homepage && \
    adduser -S -u $UID -G homepage homepage && \
    apk add --no-cache curl nginx tzdata unzip && \
    export version=$(curl --silent "https://api.github.com/repos/bastienwirtz/homer/releases/latest" \
      | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    curl -L https://github.com/bastienwirtz/homer/releases/download/$version/homer.zip -o homepage.zip && \
    unzip -q homepage.zip -d /home/homepage && \
    chown -R $UID:$GID /home/homepage && \
    rm homepage.zip && \
    apk del --purge curl unzip

# drop privileges
USER homepage

# static volume
VOLUME ["/home/homepage/assets/config.yml"]

# run!
ENTRYPOINT ["nginx", "-g", "daemon off;"]
