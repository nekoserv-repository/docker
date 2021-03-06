FROM python:2-slim

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Debian slim + python2 + pyload"
LABEL website="https://github.com/TODO/docker-pyload"
LABEL version="1.0"

# init
ARG UID
ARG GID

# copy entrypoint
COPY docker-entrypoint.sh /usr/local/bin/

# install stuff, get app & cleanup
RUN groupadd -g $GID pyload && \
    useradd -m -g pyload -u $UID pyload && \
    apt-get update && apt-get install --no-install-recommends -y curl gcc libc6-dev libcurl4-openssl-dev libssl-dev && \
    curl -L https://github.com/pyload/pyload/archive/stable.tar.gz -o pyload.tar.gz && \
    tar xzf pyload.tar.gz --strip 1 -C /home/pyload && \
    rm pyload.tar.gz && \
    chown -R pyload:pyload /home/pyload && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --no-compile pycurl pycrypto pyOpenSSL && \
    apt-get autoremove --purge -y gcc libc6-dev libcurl4-openssl-dev libssl-dev && \
    rm -rf /tmp/* /var/lib/apt/lists/* && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

# drop privileges
USER pyload

# run!
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
