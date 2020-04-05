FROM php:7.3-fpm-alpine

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + php7/rutorrent"
LABEL website="https://github.com/TODO/docker-rutorrent"
LABEL version="1.0"

# init
ARG UID
ARG GID

# add user
RUN addgroup -g $GID rutorrent && \
    adduser -S -u $UID -G rutorrent rutorrent && \
    sed -i -e 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/'g /usr/local/etc/php-fpm.d/www.conf

# drop privileges
USER rutorrent

# configuration
WORKDIR /home/rutorrent

# run!
#CMD [ "php", "./index.php" ]
CMD [ "php-fpm", "--nodaemonize" ]
