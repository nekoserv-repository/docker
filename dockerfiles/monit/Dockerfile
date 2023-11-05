FROM python:3.10-alpine

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + monit"
LABEL website="https://github.com/TODO/docker-monit"
LABEL version="1.0"

# init
ARG UID
ARG GID
ARG SMTP_HOST
ARG SMTP_PORT
ARG SMTP_USR
ARG SMTP_PASS
ARG ALERT_EMAIL

# copy stuff
COPY monitrc /etc/monitrc
COPY *.py /usr/local/bin/

# install stuff, get app & cleanup
RUN sed -i -e "s/SMTP_HOST/`echo $SMTP_HOST`/g" /etc/monitrc && \
    sed -i -e "s/SMTP_PORT/`echo $SMTP_PORT`/g" /etc/monitrc && \
    sed -i -e "s/SMTP_USR/`echo $SMTP_USR`/g" /etc/monitrc && \
    sed -i -e "s/SMTP_PASS/`echo $SMTP_PASS`/g" /etc/monitrc && \
    sed -i -e "s/ALERT_EMAIL/`echo $ALERT_EMAIL`/g" /etc/monitrc && \
    addgroup -g $GID monit && \
    adduser -S -h /tmp -u $UID -G monit monit && \
    apk add --no-cache curl monit tzdata && \
    chown monit:monit /etc/monitrc /usr/local/bin/* && \
    chmod 0500 /etc/monitrc /usr/local/bin/docker_*.py && \
    pip3 install --no-cache-dir --upgrade pip docker

# drop privileges
USER monit

# run!
CMD ["/usr/bin/monit", "-I", "-v"]
