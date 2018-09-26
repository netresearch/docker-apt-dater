#!/usr/bin/env bash
set -e


if [ "$1" == "init" ]; then
    echo 'Copy README and example files into you local host folder.'
    cp -vr /var/apt-dater-example/* /var/apt-dater-init/
    echo 'Done. Please check your folder, and take a look in the README.'
    exit 0
fi

if [ `ls -1 /opt/apt-dater/hosts.d/ | wc -l` == 0 ]; then
    echo ' '
    echo '========================================================================'
    echo 'No config files found in /opt/apt-dater/hosts.d/'
    echo '------------------------------------------------------------------------'
    echo 'You need to provide host config files by binding them into the container'
    echo 'Please refer to the README.'
    echo 'You can prepare your folder with example files by running:'
    echo ' '
    echo '$ docker run -v `pwd`:/var/apt-dater-init netresearch/apt-dater init'
    echo ' '
    echo 'This will copy example docker-compose.yml and hosts.xml and README to'
    echo 'your current folder.'
    echo ' '
else
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
fi

exec "$@"
