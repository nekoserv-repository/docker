FROM python:2-alpine3.11

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Base image for couchpotato : alpine, python2, pyopenssl, lxml, etc"
LABEL website="https://github.com/nekoserv-repository/docker"
LABEL version="0.1"

# install stuff
RUN apk add --no-cache curl cython gcc libffi-dev libxml2-dev libxslt libxslt-dev musl-dev openssl-dev tzdata unzip unrar && \
    pip install pyopenssl lxml && \
    apk del --purge curl cython gcc libffi-dev libxml2-dev libxslt-dev musl-dev openssl-dev unzip

# run!
CMD ["sh"]
