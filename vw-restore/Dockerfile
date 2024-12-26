FROM alpine:3.21

# copy script
COPY vw-restore.sh /usr/local/bin/vw-restore

# install stuff and cleanup
RUN apk add --no-cache curl gettext-envsubst tzdata unzip && \
    # \
    ## get s5cmd \
    # \
    export version=$(curl --silent "https://api.github.com/repos/peak/s5cmd/releases/latest" \
      |  awk '/"tag_name":/ {print; exit;}' | sed -E 's/.*"v([^"]+)".*/\1/') && \
    curl -L https://github.com/peak/s5cmd/releases/download/v${version}/s5cmd_${version}_Linux-64bit.tar.gz -o- | tar -C /usr/local/bin/ -zx s5cmd && \
    # \
    ## fix permissions \
    # \
    chmod 0700 /usr/local/bin/* && \
    # \
    ## clean \
    # \
    apk del --purge curl && \
    rm -rf /var/cache/apk/* /tmp/*

# run!
CMD ["/usr/local/bin/vw-restore"]
