#!/usr/bin/env bash
set -ex

cat /opt/apt-dater/hosts.d.xml.head /opt/apt-dater/hosts.d/*.xml /opt/apt-dater/hosts.d.xml.foot > /opt/apt-dater/hosts.d.xml
cat /opt/apt-dater/hosts.d.xml


# first arg is `-f` or `--some-option` - set apt-dater as entrypoint command and add provided arguments
if [ "${1#-}" != "$1" ]; then
    set -- apt-dater -c /opt/apt-dater/apt-dater.xml "$@"
fi

# no arguments at all - set apt-dater as entry point command
if [ $# -eq 0 ]; then
    set -- apt-dater -c /opt/apt-dater/apt-dater.xml "$@"
fi


exec "$@"
