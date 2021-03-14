FROM python:3.8-slim

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Base image for sabnzbd : debian, python3, par2, etc"
LABEL website="https://github.com/nekoserv-repository/docker"
LABEL version="0.4"

# install stuff
RUN sed -i -e '/^deb / s/$/ non-free/' /etc/apt/sources.list && \
    apt-get update && apt-get install --no-install-recommends -y curl p7zip-full par2 unrar unzip && \
    pip install cheetah3 cryptography sabyenc3 'feedparser<6.0.0' configobj cherrypy chardet && \
    apt-get autoremove --purge -y curl && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# run!
CMD ["sh"]
