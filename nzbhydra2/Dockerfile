FROM eclipse-temurin:17-jre

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Alpine + jre + NZBHydra2"
LABEL website="https://github.com/TODO/docker-nzbhydra2"
LABEL version="1.0"

# add group/user, then get app & cleanup
RUN UID=1000 && GID=1000 && \
    groupadd -g $GID nzbhydra2 && \
    useradd -m -g nzbhydra2 -u $UID nzbhydra2 && \
    mkdir /home/nzbhydra2/data && \
    apt-get update && apt-get upgrade -y && \
    apt-get install --no-install-recommends -y curl python3 unzip && \
    export version=$(curl --silent "https://api.github.com/repos/theotherp/nzbhydra2/releases/latest" \
      | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | awk '{print(substr($1,2))}') && \
    curl -L https://github.com/theotherp/nzbhydra2/releases/download/v$version/nzbhydra2-$version-amd64-linux.zip -o nzbhydra2.zip && \
    unzip -q nzbhydra2.zip -d /home/nzbhydra2 && \
    chown -R nzbhydra2 /home/nzbhydra2 && \
    chmod +x /home/nzbhydra2/nzbhydra2 /home/nzbhydra2/core && \
    apt-get autoremove --purge -y curl unzip && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# drop privileges
USER nzbhydra2

# change workdir
WORKDIR /home/nzbhydra2

# run!
ENTRYPOINT ["python3", "./nzbhydra2wrapperPy3.py", "--datafolder", "/home/nzbhydra2/data/"]
