FROM registry.opensuse.org/opensuse/tumbleweed

COPY zypp.conf /etc/zypp/zypp.conf
COPY zy /usr/bin/zy

RUN curl https://raw.githubusercontent.com/terrapkg/tuatara/refs/heads/tumbleweed/tuatara/release/tuatara.repo -o /etc/zypp/repos.d/tuatara.repo && \
    zy up -y && \
    zy in -y subatomic-cli anda{,-srpm-macros} terra-appstream-helper gh wget less mold sudo jq && \
    zy cc
