FROM registry.fedoraproject.org/fedora-minimal:rawhide

COPY dnf.conf /etc/dnf/dnf.conf

RUN sed -i 's/.fc%{fedora}/.fcrawhide/g' /usr/lib/rpm/macros.d/macros.dist && \
    sed -i '/\[fedora\]\|\[updates\]/a enabled=0' /etc/dnf/dnf.conf && \
    sed -iE '/^metadata_expire/d' /etc/yum.repos.d/fedora-rawhide.repo && \
    cat /etc/yum.repos.d/fedora-rawhide.repo >> /etc/dnf/dnf.conf && \
    cat /etc/dnf/dnf.conf && \
    curl https://github.com/mozilla/sccache/releases/download/v0.15.0/sccache-v0.15.0-$(arch)-unknown-linux-musl.tar.gz | tar x --strip-components=1 && \
    install -Dpm755 sccache -t /usr/bin && \
    dnf in -y --nogpgcheck --repo=terra terra-gpg-keys && \
    dnf up -y && \
    dnf swap -y systemd-standalone-sysusers systemd && \
    dnf in -y terra-mock-configs subatomic-cli anda{,-srpm-macros} terra-appstream-helper mock-scm \
        gh wget less podman fuse-overlayfs dnf5-plugins util-linux-script mold sudo jq @buildsys-build && \
    dnf clean packages dbcache
