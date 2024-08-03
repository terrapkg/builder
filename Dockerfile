FROM docker.io/library/almalinux:9-minimal

RUN sed -i 's@^enabled=0@enabled=1@' /etc/yum.repos.d/almalinux-crb.repo
RUN curl https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -o epel-release-latest-9.noarch.rpm
RUN rpm -i ./*.rpm
RUN curl https://cli.github.com/packages/rpm/gh-cli.repo -o /etc/yum.repos.d/gh-cli.repo
RUN microdnf install -y --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' --setopt='terra.gpgkey=https://repos.fyralabs.com/terra$releasever/key.asc' terra-release

RUN microdnf -y --setopt=install_weak_deps=0 install terra-mock-configs subatomic-cli anda mock rpm-build mock-scm rpmlint git-core git-lfs curl wget less podman fuse-overlayfs sudo gh

RUN microdnf clean all
