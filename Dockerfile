FROM registry.fedoraproject.org/fedora:37

RUN dnf update -y
RUN dnf install -y dnf-plugins-core
RUN dnf config-manager --add-repo='https://github.com/andaman-common-pkgs/subatomic-repos/raw/main/terra37.repo'
RUN dnf -y install anda-mock-configs subatomic-cli anda mock rpm-build mock-scm rpmlint dnf-plugins-core createrepo_c git gcc curl wget less

RUN dnf clean all
RUN rm -rf /var/cache/{dnf,yum}
