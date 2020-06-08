FROM python:2-alpine3.11

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Base image for sabnzbd : alpine, python2, par2, etc"
LABEL website="https://github.com/nekoserv-repository/docker"
LABEL version="0.2"

# install stuff
RUN apk add --no-cache automake autoconf make curl g++ libffi-dev musl-dev openssl-dev p7zip tzdata unrar && \
    mkdir /home/tmp && cd /home/tmp && \
    curl -L $(curl --silent "https://api.github.com/repos/Parchive/par2cmdline/releases/latest" \
      | grep '"tarball_url":' | sed -E 's/.*"([^"]+)".*/\1/') -o par2cmdline.tar.gz && \
    tar xzf par2cmdline.tar.gz && rm par2cmdline.tar.gz && \
    cd Parchive-par2cmdline-* && \
    ./automake.sh && \
    ./configure && \
    make && \
    make check && \
    make install && cd && \
    rm -rf /home/tmp && \
    pip install cheetah3 cryptography sabyenc && \
    apk del --purge automake autoconf curl g++ make libffi-dev musl-dev openssl-dev

# run!
CMD ["sh"]
