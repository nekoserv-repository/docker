FROM debian:12-slim

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Debian & trilium"
LABEL website="https://github.com/TODO/docker-trilium"
LABEL version="1.0"

# init
ARG UID
ARG GID

# install stuff, get app & cleanup
RUN groupadd -g $GID trilium && \
    useradd -m -g trilium -u $UID trilium && \
    apt-get update && apt-get install --no-install-recommends -y ca-certificates curl tzdata xz-utils && \
    export version=$(curl --silent "https://api.github.com/repos/zadam/trilium/releases/latest" \
      | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/') && \
    curl -L https://github.com/zadam/trilium/releases/download/v0.59.1/trilium-linux-x64-server-0.59.1.tar.xz -o trilium.tar.xz && \
    tar --xz -xf trilium.tar.xz --strip 1 -C /home/trilium && \
    chown -R trilium:trilium /home/trilium && \
    rm trilium.tar.xz && \
    apt-get autoremove --purge -y curl xz-utils && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# drop privileges
USER trilium

# workdir
WORKDIR /home/trilium

# run!
ENTRYPOINT ["/home/trilium/trilium.sh"]
