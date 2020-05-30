FROM alpine:3.12

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine & aria2 webui (nginx rpc2)"
LABEL website="https://github.com/TODO/docker-aria2-webui"
LABEL version="1.0"

# init
ARG ARIA2_CONTAINER_NAME
ARG ARIA2_PORT
ARG ARIA2_TOKEN

# copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# install - using random UUID for user
RUN sed -i -e "s/ARIA2_CONTAINER_NAME/`echo $ARIA2_CONTAINER_NAME`/g" /etc/nginx/nginx.conf && \
  sed -i -e "s/ARIA2_PORT/`echo $ARIA2_PORT`/g" /etc/nginx/nginx.conf && \
  apk add --no-cache curl nginx tzdata unzip && \
  export UUID=$(( $RANDOM % 9000 + 1000 )) && \
  addgroup -g $UUID aria2-webui && \
  adduser -S -u $UUID -G aria2-webui aria2-webui && \
  addgroup aria2-webui tty && \
  curl -L https://github.com/ziahamza/webui-aria2/archive/master.zip -o aria2-webui.zip && \
  unzip -q aria2-webui.zip -d /home/aria2-webui && \
  mv /home/aria2-webui/*-master /home/aria2-webui/www/ && \
  chown -R aria2-webui:aria2-webui /home/aria2-webui && \
  sed -i -e "s/port: 6800/port: window.location.port || (location.protocol === 'https:' ? '443' : '80')/g" /home/aria2-webui/www/docs/app.js && \
  sed -i -e 's/path: "\/jsonrpc"/path: "\/aria2\/jsonrpc"/g' /home/aria2-webui/www/docs/app.js && \
  sed -i -e "s/auth: {}/auth: { token: '`echo $ARIA2_TOKEN`' }/g" /home/aria2-webui/www/docs/app.js && \
  sed -i -e "s/encrypt: !1/encrypt: true/g" /home/aria2-webui/www/docs/app.js && \
  rm aria2-webui.zip && \
  apk del --purge curl unzip

# drop privileges
USER aria2-webui

# run!
ENTRYPOINT ["nginx", "-g", "daemon off;"]
