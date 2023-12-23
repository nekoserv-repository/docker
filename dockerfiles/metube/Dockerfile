FROM alexta69/metube

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + python3 + metube"
LABEL website="https://github.com/TODO/docker-metube"
LABEL version="1.0"

# install stuff, get app & cleanup
RUN UID=1000 && GID=1000 && \
    addgroup -g $GID metube && \
    adduser -S -u $UID -G metube metube && \
    apk add --no-cache tzdata

# drop privileges
USER metube

# run!
CMD ["python3", "/app/app/main.py"]
