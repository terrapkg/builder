FROM registry.fedoraproject.org/fedora-minimal:rawhide

COPY dnf.conf /etc/dnf/dnf.conf

RUN curl https://cli.github.com/packages/rpm/gh-cli.repo -o /etc/yum.repos.d/gh-cli.repo

RUN dnf5 in -y --setopt=install_weak_deps=False --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' --setopt='terra.gpgkey=https://repos.fyralabs.com/terrarawhide/key.asc' terra-{release{,-extras},mock-configs} subatomic-cli anda mock rpm-build mock-scm rpmlint git-{core,lfs} wget less podman fuse-overlayfs sudo gh dnf5-plugins createrepo_c script

# Hack to fix %dist
RUN sed -i 's/.fc%{fedora}/.fcrawhide/g' /usr/lib/rpm/macros.d/macros.dist
