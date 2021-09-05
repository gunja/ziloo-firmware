#
# The builder is based on Debian to get the biggest range of tools
# > docker build -f builder.Dockerfile --target image-builder .
#
FROM ruby:3.0-slim as image-builder

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \

	# Install dependencies
	# See https://buildroot.org/downloads/manual/manual.html#requirement
	# MANDATORY build tools
	#which \
	#sed \
	make \
	binutils \
	build-essential \
	gcc \
	g++ \
	#bash \
	patch \
	#gzip \
	bzip2 \
	perl \
	#tar \
	cpio \
	unzip \
	rsync \
	file \
	bc \
	# MANDATORY source fetching tools
    curl \
	wget \
	# OPTIONAL recommended dependencies
	python \
	python-dev \
	xxd \
	# OPTIONAL configuration interface dependencies
	libncurses5-dev \
	#libqt5-dev \
	#libglib2.0-dev libgtk2.0-dev libglade2-dev \
	# OPTIONAL source fetching tools
	#bazaar \
	# bzr \
	cvs \
	git \
	mercurial \
	liblscp-dev \
	subversion \
	# OPTIONAL java related packages
	#javacc \
	#jarwrapper \
	# OPTIONAL documentation generation tools
	#asciidoc \
	#w3m \
	python3 \
	python3-dev \
	python3-distutils \
	python3-setuptools \
	#dblatex \

	# QEMU emulation
    qemu \
    qemu-user-static \
	# Disk Image building
    binfmt-support \
    build-essential \
    curl \
    debootstrap \
    dosfstools \
    fdisk \
    gdisk \
    kpartx \
    gzip \
    parted \
    squashfs-tools \
    u-boot-tools \
	tar \
    zip \

	# OPTIONAL graph generation tools
	#graphviz \
	#python-matplotlib \
	#
	# ADDITIONAL dependency to get root certificates
	ca-certificates \
	# ADDITIONAL dependency to get client ssh
	openssh-client \
	# ADDITIONAL dependency to get unbuffer
	expect \
	# ADDITIONAL dependency to get locale-gen
	locales \

	# More Build tools
    cmake \
    bison \
	flex \
    gcc-arm* \
	pkg-config \
    swig \
	libxml2-utils xsltproc libssl-dev \
    lzop \
    libyaml-dev \
    libusb-dev \

	## Python setup
    python3-markdown python3-distutils python3-pip && \
	echo Packages installed.

RUN gem update --system && \
    gem install --no-document serverspec

# RUN pip3 install setup-tools

## Genimage is the main tool for creating firmware disk images
COPY boards/install-genimage.sh /boards/install-genimage.sh
RUN /boards/install-genimage.sh



FROM image-builder as ziloo-builder

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	# Unsorted Tools
    debootstrap \
    gperf libc6-dev libreadline-dev \
	tofrodos \
    bc \
    gnupg \
    mtools mtd-utils \
    ncurses-base ncurses-bin dialog \
    #  && \
    # rm -rf /var/lib/apt/lists/*
	# apt-get -y autoremove && \
	# apt-get -y clean && \
	# rm -rf /var/lib/apt/lists/* && \
	# #
	# # Set locale
	locales locales-all && \
	locale-gen --purge --lang en_US.UTF-8  && \
	# #
	# # Add user
	# useradd -ms /bin/bash funkey && \
	# usermod -a -G sudo funkey && \
	# echo "funkey:funkey" | chpasswd && \
	# #
	# # Clone the FunKey-OS repository
	# git clone https://github.com/FunKey-Project/FunKey-OS.git /home/funkey/FunKey-OS && \
	# #
	# # Set file ownership
	# chown -R funkey:funkey /home/funkey
	echo Packages installed.

ENV LC_ALL en_US.UTF-8 
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en 

RUN git config --global user.email hello@thepia.com
RUN git config --global user.name "Henrik Vendelbo"

# COPY boards /boards/

# RUN /boards/install-genimage.sh

# build sd card image
# CMD /builder/build.sh
