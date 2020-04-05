FROM alpine:3.11

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine & NGiNX"
LABEL website="https://github.com/TODO/docker-nginx"
LABEL version="1.0"

# init
ARG UID
ARG GID

# install
RUN apk add --no-cache nginx tzdata && \
  mkdir -p /home/nginx/static && \
  chown $UID:$GID /home/nginx/static && \
  addgroup -g $GID ngx && \
  adduser -S -u $UID -G ngx ngx

# copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# drop privileges
USER ngx

# static volume
VOLUME ["/home/nginx/static"]

# run!
ENTRYPOINT ["nginx", "-g", "daemon off;"]
