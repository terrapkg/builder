FROM almalinux:10.1-minimal

RUN curl https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm -o epel-release-latest-10.noarch.rpm &\
    curl https://cli.github.com/packages/rpm/gh-cli.repo -o /etc/yum.repos.d/gh-cli.repo &\
    echo 'max_parallel_downloads=20' >> /etc/dnf/dnf.conf &\ 
    curl 'https://repos.fyralabs.com/terrael10/?sort=2' -o page.html &\
    wait &&\
    curl https://repos.fyralabs.com/terrael10/$(cat page.html | sed -nE 's@.*"(terra-release-[^"]+)".*@\1@p') -o terra-release.rpm &&\
    curl https://repos.fyralabs.com/terrael10/$(cat page.html | sed -nE 's@.*"(terra-gpg-keys-[^"]+)".*@\1@p') -o terra-gpg-keys.rpm &&\
    rm page.html && \
    rpm -i ./*.rpm && \
    #sed -Ei "s@^#baseurl=.+@baseurl=https://dl.fedoraproject.org/pub/epel/\$releasever_major\${releasever_minor:+.\$releasever_minor}/Everything/\$basearch/@" /etc/yum.repos.d/epel.repo && \
    #sed -Ei '/^metalink/ s/^/#/' /etc/yum.repos.d/epel.repo && \
    sed -Ei '/\[crb\]/,/^$/ s@^enabled=0$@enabled=1@' /etc/yum.repos.d/almalinux-crb.repo && \
    microdnf install -y \
        --setopt=install_weak_deps=0 \
        terra-mock-configs anda-srpm-macros terra-appstream-helper redhat-rpm-config epel-rpm-macros almalinux-release adoptium-temurin-java-repository \
        subatomic-cli anda rpm-build git-lfs podman fuse-overlayfs mold dnf-plugins-core \
        wget less gh util-linux bash bzip2 cpio diffutils findutils gawk glibc-minimal-langpack grep info patch sed tar gzip unzip which xz jq &&\
    microdnf clean all
