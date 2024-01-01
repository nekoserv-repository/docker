FROM alpine:3.19

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine & aria2 webui (nginx rpc2)"
LABEL website="https://github.com/TODO/docker-aria2-webui"
LABEL version="1.0"

# copy nginx template
COPY nginx.conf /etc/nginx/nginx.conf.template

# install - using random UUID for user
RUN apk add --no-cache curl gettext-envsubst nginx tzdata && \
    export UUID=$(( $RANDOM % 9000 + 1000 )) && \
    addgroup -g $UUID aria2-webui && \
    adduser -S -u $UUID -G aria2-webui aria2-webui && \
    addgroup aria2-webui tty && \
    curl -L https://github.com/ziahamza/webui-aria2/archive/master.tar.gz -o aria2-webui.tar.gz && \
    tar xzf aria2-webui.tar.gz --strip 1 -C /home/aria2-webui && \
    chown -R aria2-webui:aria2-webui /home/aria2-webui && \
    sed -i -e "s/port: 6800/port: window.location.port || (location.protocol === 'https:' ? '443' : '80')/g" /home/aria2-webui/docs/app.js && \
    sed -i -e 's/path: "\/jsonrpc"/path: "\/aria2\/jsonrpc"/g' /home/aria2-webui/docs/app.js && \
    sed -i -e "s/auth: {}/auth: { token: '\$ENV_ARIA2_TOKEN' }/g" /home/aria2-webui/docs/app.js && \
    sed -i -e "s/encrypt: !1/encrypt: true/g" /home/aria2-webui/docs/app.js && \
    rm aria2-webui.tar.gz && \
    rm /etc/nginx/nginx.conf && \
    apk del --purge curl

# drop privileges
USER aria2-webui

# run!
ENTRYPOINT ["sh", "-c", "envsubst '$${ENV_ARIA2_CONTAINER_NAME},$${ENV_ARIA2_PORT}' < /etc/nginx/nginx.conf.template > /tmp/nginx.conf && \
             cp -a /home/aria2-webui/docs /tmp/aria2-webui && \
             envsubst '$${ENV_ARIA2_TOKEN}' < /home/aria2-webui/docs/app.js > /tmp/aria2-webui/app.js && \
             nginx -c /tmp/nginx.conf -g 'daemon off;'"]
