FROM alpine:3.10.2

# config
ARG VERSION=1.0
ARG UID=1234
ARG GID=1234

# Dokerfile's infos
LABEL maintainer="Yuu" mail="yuu@fai.tld" \
      org.label-schema.name="Alpine & OpenVPN client" \
      org.label-schema.description="Docker image for OpenVPN" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

# copy entrypoint
COPY docker-entrypoint.sh /usr/local/bin/

# openvpn install & clean [ TODO : add gosu! ]
RUN apk add --no-cache \
     nftables \
     openvpn \
     tini \
     tzdata && \
    chmod u+x /usr/local/bin/docker-entrypoint.sh

# mount config file
VOLUME ["/openvpn-config"]

# RUN, BABY, RUN
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/docker-entrypoint.sh"]
