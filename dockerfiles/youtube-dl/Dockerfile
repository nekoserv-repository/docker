FROM recodeuk/youtube-dl-flask

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="youtube-dl-flask"
LABEL website="https://github.com/TODO/docker-youtube-dl-flask"
LABEL version="1.0"

# init
ARG UID
ARG GID

# install stuff, get app & cleanup
RUN addgroup -g $GID ytdl && \
    adduser -S -u $UID -G ytdl ytdl && \
    chown -R ytdl:ytdl /usr/src/app && \
    apk add --no-cache tzdata

# drop privileges
USER ytdl

# run!
CMD [ "python", "app.py" ]
