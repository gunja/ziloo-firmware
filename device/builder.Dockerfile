#
# The builder is based on Ubuntu to get the biggest range of tools
# > docker build -f builder.Dockerfile --target image-builder .
#
FROM ubuntu:20.04 as base-builder

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    binutils bash gzip bzip2 tar lzop cpio python python-dev zip unzip rsync file bc \
    u-boot-tools device-tree-compiler time tcl \
	autoconf libtool automake \
    time lz4 device-tree-compiler fakeroot gnupg \
    mtools parted libyaml-dev libxml2-utils libudev-dev libusb-1.0-0-dev \
    curl wget sed asciidoc git  rsync openssh-client \

    perl ruby \
	python3 \
	python3-dev \
    python3-markdown python3-pip \
	python3-distutils \
	python3-setuptools \

	# Disk Image building
    binfmt-support \
    debootstrap \
    dosfstools \
    fdisk \
    gdisk \
    kpartx \
    parted \
	xxd \
    squashfs-tools \
    u-boot-tools \

    m4 bison flex fakeroot libparse-yapp-perl \
    build-essential gcc g++ make cmake intltool pkg-config patch patchutils && \
    rm -rf /var/lib/apt/lists/*

RUN gem update --system && \
    gem install --no-document serverspec

# RUN pip3 install setup-tools


COPY device /device/

RUN /device/install-genimage.sh

FROM base-builder as ziloo-builder

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    mercurial subversion cvs \
	liblscp-dev \
    gcc-aarch64-linux-gnu \
    gcc-arm-linux-gnueabihf libssl-dev liblz4-tool genext2fs xsltproc \
    g++-7 libstdc++-7-dev autotools-dev \
    libsigsegv2  libdrm-dev \
    libncurses5 libncurses5-dev libglib2.0-dev libgtk2.0-dev libglade2-dev \
    pkg-config swig expect expect-dev \

	# QEMU emulation
    qemu \
    qemu-user-static && \

    rm -rf /var/lib/apt/lists/* && \

	## Done
	echo Packages installed.

# Installed via apt
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
RUN chmod a+rx /usr/bin/repo
RUN git config --global user.email hello@thepia.com && git config --global user.name "Henrik Vendelbo" && git config --global color.ui false


FROM ziloo-builder as base-repo-image

RUN mkdir -p /workspace/rockdev
WORKDIR /workspace
RUN repo init -u https://github.com/experientials/ziloo-firmware -m manifests/rv1126_rv1109_linux_20210904.xml
COPY manifests /workspace/.repo/manifests
RUN repo sync -m rv1126_rv1109_linux_20210904.xml -c

