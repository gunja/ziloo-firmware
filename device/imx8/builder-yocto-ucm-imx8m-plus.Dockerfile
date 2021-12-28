FROM ubuntu:20.04 as base-builder
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential \
chrpath socat cpio python python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping \
libsdl1.2-dev xterm autoconf libtool libglib2.0-dev sed cvs subversion coreutils \
texi2html docbook-utils python-pysqlite2 help2man make gcc g++ desktop-file-utils libgl1-mesa-dev \
libglu1-mesa-dev mercurial automake groff curl lzop asciidoc u-boot-tools dos2unix mtd-utils pv \
libncurses5 libncurses5-dev libncursesw5-dev libelf-dev zlib1g-dev gawk wget git-core diffstat unzip \
texinfo gcc-multilib build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
xz-utils debianutils iputils-ping && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir ~/bin && \
	curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && \
	chmod a+x ~/bin/repo && \
ENV PATH=~/bin:$PATH

RUN gem update --system && \
    gem install --no-document serverspec



FROM base-repo-image as rv1126-face-gate

WORKDIR /workspace

RUN repo sync -m rv1126_rv1109_linux_20210904_facial_gate.xml -c
RUN ./build.sh cam-crv1126s2u-facial_gate.mk
RUN FORCE_UNSAFE_CONFIGURE=1 ./build.sh
# TODO copy artifacts out of container

# rockdev/{MiniLoaderAll.bin,boot.img,misc.img,oem.img,parameter.txt,recovery.img,rootfs.ext4,rootfs.img,uboot.img,userdata.img}

# rockdev/pack/CAM-CRV1126S2U-FACIAL_GATE-GPT-20210922-1126.img 
COPY copy_dist.sh /copy_dist.sh
ENTRYPOINT /copy_dist.sh
