#
# The builder is based on Debian to get the biggest range of tools
#
FROM ruby:3.0-slim as ziloo-builder

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    binfmt-support \
    dosfstools \
    gzip \
    kpartx \
    gdisk \
    qemu \
    qemu-user-static \
    parted \
    unzip \
    xxd \
    zip 
    #  && \
    # rm -rf /var/lib/apt/lists/*

RUN gem update --system && \
    gem install --no-document serverspec

COPY scripts /scripts/

# build sd card image
# CMD /builder/build.sh
