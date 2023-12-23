FROM python:3.11-alpine

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + monit"
LABEL website="https://github.com/TODO/docker-monit"
LABEL version="1.0"

# init
ARG UID
ARG GID

# copy stuff
COPY monitrc /etc/monitrc.template
COPY *.py /usr/local/bin/

# install stuff, get app & cleanup
RUN addgroup -g $GID monit && \
    adduser -S -h /tmp -u $UID -G monit monit && \
    apk add --no-cache curl gettext-envsubst monit tzdata && \
    chown monit:monit /etc/monitrc /usr/local/bin/* && \
    chmod 0500 /etc/monitrc /usr/local/bin/docker_*.py && \
    pip3 install --no-cache-dir --upgrade pip docker

# drop privileges
USER monit

# run!
ENTRYPOINT ["sh", "-c", "envsubst '$${ENV_SMTP_HOST},$${ENV_SMTP_PORT},$${ENV_SMTP_USR},$${ENV_SMTP_PASS},$${ENV_ALERT_EMAIL}' < /etc/monitrc.template > /tmp/monitrc && \
             chmod 0400 /tmp/monitrc && \
             /usr/bin/monit -c /tmp/monitrc -I -v"]
