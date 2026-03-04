FROM registry.fedoraproject.org/fedora-minimal:rawhide

COPY dnf.conf /etc/dnf/dnf.conf

RUN \
    sed -i 's/.fc%{fedora}/.fcrawhide/g' /usr/lib/rpm/macros.d/macros.dist &&\
    sed -i '/\[fedora\]\|\[updates\]/a enabled=0' /etc/dnf/dnf.conf &&\
    sed -iE '/^metadata_expire/d' /etc/yum.repos.d/fedora-rawhide.repo &&\
    cat /etc/yum.repos.d/fedora-rawhide.repo >> /etc/dnf/dnf.conf &&\
    cat /etc/dnf/dnf.conf &&\
    dnf5 in -y --nogpgcheck --repo=terra terra-gpg-keys &&\
    dnf5 up -y &&\
    dnf5 swap -y systemd-standalone-sysusers systemd &&\
    dnf5 in -y terra-mock-configs subatomic-cli anda{,-srpm-macros} terra-appstream-helper mock-scm \
        gh wget less podman fuse-overlayfs dnf5-plugins dnf-plugins-core script mold sudo terra-sccache jq @buildsys-build &&\
    dnf5 clean packages dbcache &&\
    cp -pv /etc/pki/rpm-gpg/RPM-GPG-KEY-terra* -t /etc/pki/mock
