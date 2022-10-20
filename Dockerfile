FROM fedora:37

RUN dnf install -y dnf-plugins-core
RUN dnf config-manager --add-repo='https://github.com/andaman-common-pkgs/subatomic-repos/raw/main/ad37.repo'
RUN dnf -y install anda-mock-configs subatomic-cli anda mock rpm-build mock-scm

RUN dnf clean all
RUN rm -rf /var/cache/yum
