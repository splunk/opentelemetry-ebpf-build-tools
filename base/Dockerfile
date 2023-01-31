ARG BENV_BASE_IMAGE_DISTRO=debian
ARG BENV_BASE_IMAGE_VERSION=bullseye
FROM ${BENV_BASE_IMAGE_DISTRO}:${BENV_BASE_IMAGE_VERSION} AS build-main

################ DEPENDENCIES ################
# fixes for some of the build bugs/warnings in docker
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

ENV BENV_BASE_IMAGE_DISTRO=${BENV_BASE_IMAGE_DISTRO}
ENV BENV_BASE_IMAGE_VERSION=${BENV_BASE_IMAGE_VERSION}

ARG GO_VERSION="1.20"

# setup apt (add non-free, contrib and backports)
RUN [ "$BENV_BASE_IMAGE_DISTRO" != 'debian' ] || [ "$BENV_BASE_IMAGE_VERSION" != 'sid' ] \
|| cat > /etc/apt/sources.list << EOF \
deb http://deb.debian.org/debian/ $BENV_BASE_IMAGE_VERSION main non-free contrib \
deb http://deb.debian.org/debian-security/ $BENV_BASE_IMAGE_VERSION/updates main non-free contrib \
deb http://deb.debian.org/debian/ $BENV_BASE_IMAGE_VERSION-updates main non-free contrib \
deb http://deb.debian.org/debian/ $BENV_BASE_IMAGE_VERSION-backports main non-free contrib \
EOF

RUN apt-get -y update && apt-get -y install --no-install-recommends apt-utils
RUN apt-get upgrade -y --no-install-recommends

## packages that won't install recommended dependencies

# core tools
ARG PKG_CORE="wget curl git gnupg bc aptitude netcat-openbsd"
RUN apt-get -y install --no-install-recommends $PKG_CORE

# text tools
ARG PKG_TEXT="xxd sed ripgrep less jq"
RUN apt-get -y install --no-install-recommends $PKG_TEXT

# compilers
ARG PKG_MAKE="g++"
RUN apt-get -y install --no-install-recommends $PKG_MAKE

# build tools
ARG PKG_BUILD="ninja-build"
RUN apt-get -y install --no-install-recommends $PKG_BUILD

ARG PKG_LINTERS="clang-format clang-tidy shellcheck"
RUN apt-get -y install --no-install-recommends $PKG_LINTERS

# package managers
ARG PKG_MANAGERS="pkg-config rpm"
RUN apt-get -y install --no-install-recommends $PKG_MANAGERS

# kernel tools
ARG PKG_KERNEL="dkms build-essential"
RUN apt-get -y install --no-install-recommends $PKG_KERNEL

# dev tools
ARG PKG_DEV="gdb cgdb tmux strace"
RUN apt-get -y install --no-install-recommends $PKG_DEV

# dev libraries
ARG PKG_LIBS="libc-ares-dev libelf-dev libssl-dev libzstd-dev"
RUN apt-get -y install --no-install-recommends $PKG_LIBS

ARG PKG_PY_TEST="python3-pytest python3-dev python3-pip python3-setuptools python3-wheel pylint3"
RUN apt-get -y install --no-install-recommends $PKG_PY_TEST

# java sdk
ARG PKG_JAVA="default-jdk-headless"
RUN apt-get -y install --no-install-recommends $PKG_JAVA

# LLVM
ARG PKG_LLVM="llvm-11-dev libclang-11-dev clang-11"
RUN apt-get -y install --no-install-recommends $PKG_LLVM

## packages that will install recommended dependencies

# make tools
ARG PKG_MAKE="cmake ccache autoconf autoconf-archive automake libtool make"
RUN apt-get -y install $PKG_MAKE

# bcc dependencies
ARG PKG_BCC="bison flex"
RUN apt-get -y install $PKG_BCC

# Recent version of Go
WORKDIR /usr/local
RUN curl "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz" | tar xvz --
# recommended: add PATH=$PATH:/usr/local/go/bin to ~/.bashrc

# upgrade packages to latest
RUN apt-get upgrade -y --no-install-recommends

################ ENVIRONMENT ################
ENV HOME=/root
