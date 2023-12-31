FROM alpine:3.19

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine & nginx & homer"
LABEL website="https://github.com/TODO/docker-homer"
LABEL version="1.0"

# copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# install
RUN UID=$(( $RANDOM % 9000 + 1000 )) && \
    GID=$(( $RANDOM % 9000 + 1000 )) && \
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

# run!
ENTRYPOINT ["nginx", "-g", "daemon off;"]
