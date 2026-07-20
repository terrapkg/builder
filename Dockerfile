FROM registry.opensuse.org/opensuse/tumbleweed

COPY zypper.conf /etc/zypp/zypper.conf
COPY zy /usr/bin/zy

RUN zy up -y && \
    zy in -y subatomic-cli anda{,-srpm-macros} terra-appstream-helper gh wget less mold sudo jq && \
    zy cc
