FROM registry.fedoraproject.org/fedora-minimal:44

COPY dnf.conf /etc/dnf/dnf.conf

RUN \
    dnf5 up -y &&\
    dnf5 swap -y systemd-standalone-sysusers systemd &&\
    dnf5 in -y terra-mock-configs subatomic-cli anda{,-srpm-macros} terra-appstream-helper mock-scm \
        gh wget less podman fuse-overlayfs dnf5-plugins script mold sudo sccache jq @buildsys-build &&\
    dnf5 clean packages dbcache
