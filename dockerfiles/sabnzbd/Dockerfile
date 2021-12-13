FROM python:3.9-slim

# Dokerfile's infos
LABEL maintainer="nekoserv" mail="nekoserv@fai.tld"
LABEL description="Debian + python3 + sabnzbd"
LABEL website="https://github.com/TODO/docker-sabnzbd"
LABEL version="1.3"

# init
ARG UID
ARG GID

# install stuff
RUN groupadd -g $GID sabnzbd && \
    useradd -m -g sabnzbd -u $UID sabnzbd && \
    mkdir /home/sabnzbd/sabnzbd-release && \
    mkdir /home/sabnzbd/config && \
    mkdir /home/sabnzbd/complete && \
    mkdir /home/postprocessing && \
    mkdir /home/incomplete && \
    sed -i -e '/^deb / s/$/ non-free/' /etc/apt/sources.list && \
    apt-get update && apt-get install --no-install-recommends -y curl p7zip-full par2 unrar unzip && \
    curl https://raw.githubusercontent.com/sabnzbd/sabnzbd/master/requirements.txt -o /home/sabnzbd/sabnzbd-requirements.txt && \
    curl https://bootstrap.pypa.io/get-pip.py -o /home/sabnzbd/get-pip.py && \
    curl -L $(curl --silent "https://api.github.com/repos/sabnzbd/sabnzbd/releases/latest" \
      | grep '"tarball_url":' | sed -E 's/.*"([^"]+)".*/\1/') -o sabnzbd.tar.gz && \
    tar xzf sabnzbd.tar.gz --strip 1 -C /home/sabnzbd/sabnzbd-release/ && \
    chown -R sabnzbd:sabnzbd /home/sabnzbd && \
    rm sabnzbd.tar.gz && \
    python -m pip uninstall -y pip 2>/dev/null && \
    apt-get autoremove --purge -y curl && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# drop privileges
USER sabnzbd
WORKDIR /home/sabnzbd

# requirements
ENV PATH="/home/sabnzbd/.local/bin:${PATH}"
RUN python get-pip.py && \
    python -m pip install --no-cache-dir --no-compile --user -r sabnzbd-requirements.txt && \
    rm get-pip.py sabnzbd-requirements.txt

# volume for config, db & runtime stuff
VOLUME ["/home/sabnzbd/config"]
VOLUME ["/home/sabnzbd/complete"]
VOLUME ["/home/postprocessing"]
VOLUME ["/home/incomplete"]

# run!
ENTRYPOINT ["python", "/home/sabnzbd/sabnzbd-release/SABnzbd.py", "--logging", "1", "--config-file", "/home/sabnzbd/config/"]
