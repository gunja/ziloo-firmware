#
# The builder is based on Debian to get the biggest range of tools
#
FROM ruby:3.0-slim as ziloo-builder

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    bc \
    binfmt-support \
    cmake \
    bison \
    build-essential \
    curl \
    debootstrap \
    dosfstools \
    gcc-arm* \
    gzip \
    kpartx \
    flex gperf tar libc6-dev libreadline-dev tofrodos libxml2-utils xsltproc libssl-dev \
    lzop libncurses5-dev \
    libyaml-dev pkg-config \
    libusb-dev \
    bc \
    fdisk \
    gdisk \
    git gnupg \
    mtools mtd-utils \
    qemu \
    qemu-user-static \
    parted \
    ncurses-base ncurses-bin libncurses5-dev dialog \
    python3 python3-dev python3-markdown python3-distutils python3-pip \
    squashfs-tools \
    swig python \
    u-boot-tools \
    unzip \
    xxd \
    wget \
    zip 
    #  && \
    # rm -rf /var/lib/apt/lists/*

RUN gem update --system && \
    gem install --no-document serverspec

# RUN pip3 install setup-tools


COPY boards /boards/

RUN /boards/install-genimage.sh

# build sd card image
# CMD /builder/build.sh
