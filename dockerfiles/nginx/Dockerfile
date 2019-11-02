FROM alpine:3.10.2

# Dokerfile's infos
LABEL maintainer="Yuu" mail="yuu@fai.tld"
LABEL description="Alpine & NGiNX"
LABEL website="https://github.com/TODO/docker-nginx"
LABEL version="1.0"

# install
RUN apk add --update --no-cache nginx tzdata

# copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# drop privileges
USER nobody

# run!
CMD ["nginx", "-g", "daemon off;"]
