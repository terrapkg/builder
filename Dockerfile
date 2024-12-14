FROM quay.io/centos/centos:stream10-development

#RUN sed -i 's@^enabled=0@enabled=1@' /etc/yum.repos.d/almalinux-crb.repo &\
RUN curl https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm -o epel-release-latest-10.noarch.rpm &\
    curl https://cli.github.com/packages/rpm/gh-cli.repo -o /etc/yum.repos.d/gh-cli.repo &\
    echo 'max_parallel_downloads=20' >> /etc/dnf/dnf.conf &\
    wait

RUN rpm -i ./*.rpm && \
    sed -Ei "s@^#baseurl=.+@baseurl=https://dl.fedoraproject.org/pub/epel/\$releasever_major\${releasever_minor:+.\$releasever_minor}/Everything/\$basearch/@" /etc/yum.repos.d/epel.repo && \
    sed -Ei '/^metalink/ s/^/#/' /etc/yum.repos.d/epel.repo && \
    sed -Ei '/\[crb\]/,/^$/ s@^enabled=0$@enabled=1@' /etc/yum.repos.d/centos.repo

RUN dnf in -y --setopt=install_weak_deps=False --repofrompath 'terra,https://repos.fyralabs.com/terrael$releasever' --setopt='terra.gpgkey=https://repos.fyralabs.com/terrael$releasever/key.asc' terra-{release,mock-configs} subatomic-cli anda mock rpm-build mock-scm git-lfs wget less podman fuse-overlayfs sudo gh util-linux

RUN dnf clean all
