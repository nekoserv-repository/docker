FROM alpine:3.21

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine & NGiNX RPC2"
LABEL website="https://github.com/TODO/docker-nginx-rpc2"
LABEL version="1.0"

# copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf.template

# install
RUN apk add --no-cache gettext-envsubst nginx tzdata && \
    export UUID=$(( $RANDOM % 9000 + 1000 )) && \
    addgroup -g $UUID rpc2 && \
    adduser -S -u $UUID -G rpc2 rpc2

# drop privileges
USER rpc2

# run!
ENTRYPOINT ["sh", "-c", "envsubst < /etc/nginx/nginx.conf.template > /tmp/nginx.conf && \
             nginx -c /tmp/nginx.conf -g 'daemon off;'"]
