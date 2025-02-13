FROM quay.io/almalinuxorg/almalinux:10-kitten

#RUN sed -i 's@^enabled=0@enabled=1@' /etc/yum.repos.d/almalinux-crb.repo &\
RUN curl https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm -o epel-release-latest-10.noarch.rpm &\
    curl https://cli.github.com/packages/rpm/gh-cli.repo -o /etc/yum.repos.d/gh-cli.repo &\
    echo 'max_parallel_downloads=20' >> /etc/dnf/dnf.conf &\
    wait

RUN rpm -i ./*.rpm && \
    sed -Ei "s@^#baseurl=.+@baseurl=https://dl.fedoraproject.org/pub/epel/\$releasever_major\${releasever_minor:+.\$releasever_minor}/Everything/\$basearch/@" /etc/yum.repos.d/epel.repo && \
    sed -Ei '/^metalink/ s/^/#/' /etc/yum.repos.d/epel.repo && \
    sed -Ei '/\[crb\]/,/^$/ s@^enabled=0$@enabled=1@' /etc/yum.repos.d/almalinux-crb.repo

RUN dnf in -y --setopt=install_weak_deps=False --repofrompath 'terra,https://repos.fyralabs.com/terrael$releasever' --setopt='terra.gpgkey=https://repos.fyralabs.com/terrael$releasever/key.asc' terra-{release,mock-configs} anda-srpm-macros subatomic-cli anda rpm-build git-lfs wget less podman fuse-overlayfs gh util-linux bash bzip2 centos-stream-release cpio diffutils epel-rpm-macros findutils gawk glibc-minimal-langpack grep gzip info patch redhat-rpm-config sed tar unzip which xz dnf-plugins-core
