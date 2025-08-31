FROM registry.fedoraproject.org/fedora-minimal:rawhide

COPY dnf.conf /etc/dnf/dnf.conf

RUN \
    curl https://cli.github.com/packages/rpm/gh-cli.repo -o /etc/yum.repos.d/gh-cli.repo &&\
    dnf5 up -y &&\
    dnf5 swap -y systemd-standalone-sysusers systemd &&\
    dnf5 in -y --setopt=install_weak_deps=False \
        --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' \
        --setopt='terra.gpgkey=https://repos.fyralabs.com/terrarawhide/key.asc' \
        terra-{release{,-extras},mock-configs} subatomic-cli anda{,-srpm-macros} mock-scm adoptium-temurin-java-repository \
        gh wget less podman fuse-overlayfs dnf5-plugins script mold sudo jq @buildsys-build &&\
    sed -i 's/.fc%{fedora}/.fcrawhide/g' /usr/lib/rpm/macros.d/macros.dist &&\
    dnf5 clean packages dbcache
