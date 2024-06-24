FROM registry.fedoraproject.org/fedora-minimal:rawhide

RUN dnf5 update -y --setopt=install_weak_deps=False

RUN dnf5 install -y --setopt=install_weak_deps=False dnf5-plugins
RUN dnf5 config-manager addrepo --from-repofile='https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo'
RUN dnf5 config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo

RUN dnf5 -y --setopt=install_weak_deps=False install terra-mock-configs subatomic-cli anda mock rpm-build mock-scm rpmlint git-core git-lfs curl wget less podman fuse-overlayfs sudo gh

RUN dnf5 clean all
