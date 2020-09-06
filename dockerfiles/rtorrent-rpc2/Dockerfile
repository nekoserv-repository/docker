FROM alpine:3.12

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine & NGiNX RPC2"
LABEL website="https://github.com/TODO/docker-nginx-rpc2"
LABEL version="1.0"

# init
ARG UUID
ARG CONTAINER_NAME
ARG RTORRENT_PORT

# copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# install
RUN sed -i -e "s/CONTAINER_NAME/`echo $CONTAINER_NAME`/g" /etc/nginx/nginx.conf && \
  sed -i -e "s/RTORRENT_PORT/`echo $RTORRENT_PORT`/g" /etc/nginx/nginx.conf && \
  apk add --no-cache nginx tzdata && \
  export UUID=$(( $RANDOM % 9000 + 1000 )) && \
  addgroup -g $UUID rpc2 && \
  adduser -S -u $UUID -G rpc2 rpc2

# drop privileges
USER rpc2

# run!
ENTRYPOINT ["nginx", "-g", "daemon off;"]
