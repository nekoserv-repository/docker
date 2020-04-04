FROM python:2-alpine3.11

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + python2 + par2"
LABEL website="https://github.com/nekoserv-repository/docker"
LABEL version="0.1"

# install stuff to build par2cmdline, then get par2, build, install & cleanup
RUN apk add --no-cache curl g++ automake autoconf make && \
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
  apk del --purge curl g++ automake autoconf make

# run!
CMD ["sh"]
