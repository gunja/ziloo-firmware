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
