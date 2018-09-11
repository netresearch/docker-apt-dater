#!/usr/bin/env bash
set -ex

cat /opt/apt-dater/hosts.d.xml.head /opt/apt-dater/hosts.d/*.xml /opt/apt-dater/hosts.d.xml.foot > /opt/apt-dater/hosts.d.xml
cat /opt/apt-dater/hosts.d.xml

exec apt-dater -c /opt/apt-dater/apt-dater.xml "$@"
