FROM alpine:3.19

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + Proton"
LABEL website="https://github.com/TODO/docker-proton"
LABEL version="1.0"

# copy shell file
COPY proton.sh /usr/local/sbin/
COPY aria2.py /usr/local/sbin/

# install stuff
RUN echo "@edge-community https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "@edge-testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache py3-natpmp@edge-testing libnatpmp@edge-community py3-urllib3 tini tzdata && \
    chmod 0700 /usr/local/sbin/proton.sh && \
    chmod 0700 /usr/local/sbin/aria2.py

# RUN, BABY, RUN
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/sbin/proton.sh"]
