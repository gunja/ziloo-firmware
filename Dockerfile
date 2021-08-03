#
# The builder is based on Debian to get the biggest range of tools
#
FROM debian:stretch as ziloo-builder

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    binfmt-support \
    dosfstools \
    gzip \
    kpartx \
    qemu \
    qemu-user-static \
    ruby \
    unzip \
    xxd \
    zip \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN gem update --system && \
    gem install --no-document serverspec

COPY scripts /scripts/

# build sd card image
# CMD /builder/build.sh


#
# The system is run on Alpine Linux
#
FROM alpine:3.13 as base
RUN apk add --update ca-certificates # Certificates for SSL

RUN apk update && apk add \
    bc \
    binutils \
    bzip2 \
    curl \
    dosfstools \
    gzip \
    make \
    whois \
    patch \
    rsync \
    ruby \
    sed \
    tar \
    unzip \
    wget \
    bison \
    flex \
    ruby \
    zip


FROM alpine:3.13
RUN apk add --update ca-certificates # Certificates for SSL

RUN apk update && apk add \
    bc \
    binutils \
    bzip2 \
    curl \
    cpio \
    g++ \
    gcc \
    git \
    gzip \
    make \
    mercurial \
    whois \
    patch \
    perl \
    rsync \
    sed \
    tar \
    vim \ 
    unzip \
    wget \
    bison \
    flex \
    libfdt

# Install python/pip
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

# Install ARM cross compiler and i386 header files
# RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    # gcc-arm-linux-gnueabihf \
    # --no-install-recommends; \
    # apt-get clean

ENV ARCH arm
ENV CROSS_COMPILE /usr/bin/arm-linux-gnueabihf-