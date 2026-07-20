FROM registry.fedoraproject.org/fedora-minimal:45

COPY dnf.conf /etc/dnf/dnf.conf

RUN dnf in -y --nogpgcheck --repo=terra terra-gpg-keys && \
    dnf up -y && \
    dnf swap -y systemd-standalone-sysusers systemd && \
    dnf in -y terra-mock-configs subatomic-cli anda{,-srpm-macros} terra-appstream-helper mock-scm \
        gh wget less podman fuse-overlayfs dnf5-plugins util-linux-script mold sudo terra-sccache jq @buildsys-build && \
    dnf clean packages dbcache
