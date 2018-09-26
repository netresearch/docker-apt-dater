FROM debian:unstable-slim

LABEL maintainer="Sebastian Mendel <sebastian.mendel@netresearch.de>"

ENV TERM=xterm \
    DEBIAN_FRONTEND=noninteractive

RUN set -ex \
# FIX: dash.preinst: cannot remove /usr/share/man/man1/sh.distrib.1.gz: No such file or directory
 && mkdir -p /usr/share/man/man1 \
 && touch /usr/share/man/man1/sh.distrib.1.gz \
# /FIX
 && apt-get update \
 && apt-get upgrade --yes -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-all" --no-install-recommends --purge --auto-remove \
 && apt-get install --yes -o Dpkg::Options::="--force-confnew" --no-install-recommends --purge --auto-remove \
    apt-dater less \
 && apt-get autoremove \
 && apt-get clean -y \
 && rm -rf /tmp/* \
 && rm -rf /var/tmp/* \
 && for logs in `find /var/log -type f`; do > $logs; done \
 && rm -rf /usr/share/locale/* \
 && rm -rf /usr/share/man/* \
 && rm -rf /usr/share/doc/* \
 && rm -rf /var/lib/apt/lists/* \
 && rm -f /var/cache/apt/*.bin

VOLUME /opt/apt-dater

ADD setup/ / 
ADD docker-compose.yml /var/apt-dater-example/
ADD README.rst /var/apt-dater-example/
ADD hosts.d/host.xml.example /var/apt-dater-example/hosts.d/example.xml
ADD contrib/apt-dater /var/apt-dater-example/apt-dater

ENTRYPOINT ["/entrypoint.sh"]
