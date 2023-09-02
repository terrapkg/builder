FROM registry.fedoraproject.org/fedora-minimal:39

RUN dnf5 update -y --setopt=install_weak_deps=False
RUN dnf5 install -y --setopt=install_weak_deps=False dnf-plugins-core dnf
RUN dnf config-manager --add-repo='https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo'
RUN dnf5 -y --setopt=install_weak_deps=False install terra-mock-configs subatomic-cli anda mock rpm-build mock-scm rpmlint git-core curl wget less podman fuse-overlayfs sudo

RUN dnf5 clean all
RUN rm -rf /var/cache/{dnf,yum}
