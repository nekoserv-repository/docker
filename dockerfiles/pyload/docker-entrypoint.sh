#!/usr/bin/env sh

## TODO
# - make a to-do list
#

# remove pid file if exists
if [ -f "$HOME/.pyload/pyload.pid" ]; then
    rm $HOME/.pyload/pyload.pid
fi

# run!
exec $HOME/pyLoadCore.py "$@"
