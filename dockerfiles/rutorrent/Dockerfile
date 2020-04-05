FROM alpine:3.11

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + nginx/static rutorrent"
LABEL website="https://github.com/TODO/docker-rutorrent"
LABEL version="1.0"

# init
ARG UID
ARG GID
ARG CONTAINER_NAME
ARG RTORRENT_PORT

# copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# add group/user, then get app & cleanup
RUN addgroup -g $GID rutorrent && \
    adduser -S -u $UID -G rutorrent rutorrent && \
    #mkdir /home/rutorrent/data/ && \
    apk add --no-cache nginx && \
    #apk add --no-cache curl nginx unzip && \
    #export version=$(curl --silent "https://api.github.com/repos/Novik/ruTorrent/releases/latest" \
    #  | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | awk '{print(substr($1,2))}') && \
    #curl -L https://github.com/Novik/ruTorrent/archive/v$version.zip -o rutorrent.zip && \
    #unzip -q rutorrent.zip -d /home/rutorrent && \
    #mv /home/rutorrent/ruTorrent-* /home/rutorrent/ruTorrent/ && \
    #chown -R rutorrent /home/rutorrent && \
    #rm rutorrent.zip && \
    #apk del --purge curl unzip && \
    sed -i -e "s/CONTAINER_NAME/`echo $CONTAINER_NAME`/g" /etc/nginx/nginx.conf && \
    sed -i -e "s/RTORRENT_PORT/`echo $RTORRENT_PORT`/g" /etc/nginx/nginx.conf

# drop privileges
USER rutorrent

# volume for app
#VOLUME ["/home/rutorrent/"]

# run!
ENTRYPOINT ["nginx", "-g", "daemon off;"]
