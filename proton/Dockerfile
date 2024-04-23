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
RUN apk add --no-cache py3-pip tini tzdata && \
    pip install --break-system-packages --no-cache-dir py-natpmp urllib3 && \
    chmod 0700 /usr/local/sbin/proton.sh && \
    chmod 0700 /usr/local/sbin/aria2.py

# RUN, BABY, RUN
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/sbin/proton.sh"]

#docker tag 9b17ba233bcb protontest:latest
