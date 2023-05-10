FROM alpine:3.18

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine & ping-me"
LABEL website="https://github.com/TODO/docker-ping-me"
LABEL version="1.0"

# install
RUN UID=$(( $RANDOM % 9000 + 1000 )) && \
    GID=$(( $RANDOM % 9000 + 1000 )) && \
    addgroup -g $GID ping-me && \
    adduser -S -u $UID -G ping-me ping-me && \
    apk add --no-cache darkhttpd tzdata && \
    echo "OK." > /home/ping-me/index.html

# drop privileges
USER ping-me

# run!
ENTRYPOINT ["darkhttpd", "/home/ping-me", "--port", "39387", "--maxconn", "5"]
