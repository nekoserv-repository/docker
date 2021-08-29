FROM python:3.9-slim

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Base image for sabnzbd : debian, python3, par2, etc"
LABEL website="https://github.com/nekoserv-repository/docker"
LABEL version="0.5"

# install stuff
RUN sed -i -e '/^deb / s/$/ non-free/' /etc/apt/sources.list && \
    apt-get update && apt-get install --no-install-recommends -y curl p7zip-full par2 unrar unzip && \
    curl https://raw.githubusercontent.com/sabnzbd/sabnzbd/master/requirements.txt -o requirements.txt && \
    pip install -r requirements.txt && rm requirements.txt && \
    apt-get autoremove --purge -y curl && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# run!
CMD ["sh"]
