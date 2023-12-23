#!/usr/bin/env sh

# remove lock file if exists
if [ -f ~/session/rtorrent.lock ]; then
  rm -f ~/session/rtorrent.lock;
fi

# run!
exec /usr/bin/rtorrent -s ~/session/
