FROM registry.fedoraproject.org/fedora-minimal:42

COPY dnf.conf /etc/dnf/dnf.conf

RUN curl https://cli.github.com/packages/rpm/gh-cli.repo -o /etc/yum.repos.d/gh-cli.repo

RUN dnf5 swap -y systemd-standalone-sysusers systemd

RUN dnf5 in -y --setopt=install_weak_deps=False --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' --setopt='terra.gpgkey=https://repos.fyralabs.com/terra42/key.asc' terra-{release{,-extras},mock-configs} subatomic-cli anda{,-srpm-macros} mock-scm rpmlint gh git-lfs wget less podman fuse-overlayfs dnf5-plugins script mold which sudo

# Hack to fix %dist
RUN sed -i 's/.fc%{fedora}/.fc42/g' /usr/lib/rpm/macros.d/macros.dist

RUN dnf5 downgrade dnf5 -y
