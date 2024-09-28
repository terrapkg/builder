FROM registry.fedoraproject.org/fedora-minimal:40

RUN echo 'max_parallel_downloads=20' >> /etc/dnf/dnf.conf
RUN dnf5 update -y --setopt=install_weak_deps=False

RUN dnf5 install -y --setopt=install_weak_deps=False dnf5-plugins
RUN dnf5 config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo

RUN dnf5 in -y --setopt=install_weak_deps=False --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' --setopt='terra.gpgkey=https://repos.fyralabs.com/terra40/key.asc' terra-{release,mock-configs} subatomic-cli anda mock rpm-build mock-scm rpmlint git-lfs wget less podman fuse-overlayfs sudo gh

RUN dnf5 clean all
