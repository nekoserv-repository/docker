FROM alpine:3.21

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + Proton"
LABEL website="https://github.com/TODO/docker-proton"
LABEL version="1.0"

# copy shell file
COPY proton.sh /usr/local/sbin/
COPY aria2.py /usr/local/sbin/

# install stuff
RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache python3 py3-pip tini tzdata uv@edge && \
    uv pip install --break-system-packages --system py-natpmp urllib3 && \
    apk del --purge py3-pip uv && \
    rm -rf /var/cache/apk/* ~/.cache/* && \
    chmod 0700 /usr/local/sbin/proton.sh && \
    chmod 0700 /usr/local/sbin/aria2.py

# RUN, BABY, RUN
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/sbin/proton.sh"]
