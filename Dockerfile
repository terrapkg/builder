FROM registry.fedoraproject.org/fedora-minimal:rawhide

COPY dnf.conf /etc/dnf/dnf.conf

RUN \
    dnf5 up -y &&\
    dnf5 swap -y systemd-standalone-sysusers systemd &&\
    dnf5 in -y terra-mock-configs subatomic-cli anda{,-srpm-macros} mock-scm \
        gh wget less podman fuse-overlayfs dnf5-plugins script mold sudo jq @buildsys-build &&\
    sed -i 's/.fc%{fedora}/.fcrawhide/g' /usr/lib/rpm/macros.d/macros.dist &&\
    dnf5 clean packages dbcache
