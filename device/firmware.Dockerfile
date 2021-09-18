#
# ARM7 Firmware Containers
#


#
# Firmware runtime base
#
# 3.13 is broken on arm7 due to a time64 issue (nslookup http://dl-cdn.alpinelinux.org)
#
FROM alpine:3.12 as base

LABEL maintainer="Henrik Vendelbo <thepia@pm.me>"

# Certificates for SSL
RUN set -x && apk add --no-cache --virtual=.build-dependencies wget ca-certificates 

RUN apk update --no-cache && apk add \
    bzip2 \
    binutils \
    busybox \
    curl \
    cpio \
    lsblk \
    gzip \
    whois \
    patch \
    rsync \
    sed \
    tar \
    unzip \
    wget \
    bison \
    flex 

# Install python
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python

#
# Native compiling container setup on Raspberry Pi or Apple M1
#
FROM base as develop

RUN apk update && apk add \
    bc \
    binutils \
    cmake \
    g++ \
    gcc \
    git \
    make \
    mercurial \
    openssl \
    perl \
    vim \ 
    libfdt

FROM develop as develop-x11

ENV DISPLAY :99
ENV RESOLUTION 1920x1080x24

# Xfce4 Graphical desktop
RUN apk add --no-cache x11vnc xfce4 openbox \
    xfce4-terminal \
    xfce4-screensaver \
    lightdm-gtk-greeter \
    && addgroup alpine \
    && adduser  -G alpine -s /bin/sh -D alpine \
    && echo "alpine:alpine" | /usr/sbin/chpasswd \
    && echo "alpine    ALL=(ALL) ALL" >> /etc/sudoers

USER alpine
WORKDIR /home/alpine

RUN mkdir -p /home/alpine/.vnc && x11vnc -storepasswd alpine /home/alpine/.vnc/passwd

EXPOSE 5900

ADD device/alpine-rpi/setup/develop/etc /etc
COPY device/alpine-rpi/setup/dev-entrypoint.sh /usr/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]

#
# Cross compiling container for building the SDK
#
# FROM --platform=linux/aarch64 base as cross-develop
# RUN apk add --update ca-certificates # Certificates for SSL

# RUN apk update && apk add \
#     bc \
#     binutils \
#     cmake \
#     g++ \
#     gcc \
#     gzip \
#     make \
#     mercurial \
#     perl \
#     vim \ 
#     libfdt

# # Install python/pip
# ENV PYTHONUNBUFFERED=1
# RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
# RUN python3 -m ensurepip
# RUN pip3 install --no-cache --upgrade pip setuptools

# # Install ARM cross compiler and i386 header files
# # RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq \
#     # gcc-arm-linux-gnueabihf \
#     # --no-install-recommends; \
#     # apt-get clean

# ENV ARCH arm
# ENV CROSS_COMPILE /usr/bin/arm-linux-gnueabihf-
