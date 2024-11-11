FROM python:3.12-alpine

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + monit"
LABEL website="https://github.com/TODO/docker-monit"
LABEL version="1.0"

# copy stuff
COPY monitrc /etc/monitrc.template
COPY *.py /usr/local/bin/

# install stuff, get app & cleanup
RUN UID=1000 && GID=1000 && \
    addgroup -g $GID monit && \
    adduser -S -h /tmp -u $UID -G monit monit && \
    echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache curl gettext-envsubst monit tzdata uv@edge && \
    chown monit:monit /etc/monitrc /usr/local/bin/* && \
    chmod 0500 /etc/monitrc /usr/local/bin/docker_*.py && \
    uv pip install --system docker && \
    rm -rf /var/cache/apk/* ~/.cache/*

# drop privileges
USER monit

# run!
ENTRYPOINT ["sh", "-c", "envsubst '$${ENV_SMTP_HOST},$${ENV_SMTP_PORT},$${ENV_SMTP_USR},$${ENV_SMTP_PASS},$${ENV_ALERT_EMAIL}' < /etc/monitrc.template > /tmp/monitrc && \
             chmod 0400 /tmp/monitrc && \
             /usr/bin/monit -c /tmp/monitrc -I -v"]
