FROM registry.fedoraproject.org/fedora-minimal:rawhide

COPY dnf.conf /etc/dnf/dnf.conf

RUN dnf5 update -y --setopt=install_weak_deps=False

RUN curl https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo -Lo /etc/yum.repos.d/terra.repo
RUN curl https://cli.github.com/packages/rpm/gh-cli.repo -o /etc/yum.repos.d/gh-cli.repo

RUN dnf5 -y --setopt=install_weak_deps=False install subatomic-cli anda rpm-build rpmlint git-core git-lfs wget less fuse-overlayfs sudo gh dnf5-plugins createrepo_c

# Hack to fix %dist
RUN sed -i 's/.fc%{fedora}/.fcrawhide/g' /usr/lib/rpm/macros.d/macros.dist
