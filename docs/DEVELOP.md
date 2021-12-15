# Setting up Development environment

Fork the main branch if you are making general improvements.
And make a PR to merge them on to the main branch as well as the relevant hardware(`hw/*`) branches.

Fork a hardware(`hw/*`) branch, if you work on a firmware release for a specific platform.
If possible you should fork the main branch for work on firmware work and later cherry pick the merge onto
the relevant hardware branches.
Hardware branches have to be kept compatible with main branch, but can diverge from it.
Hardware branches currently do not allow force push to ensure no history is lost.
In future setups there may be release branches that hold the qualified hardware branches which
have passed tests and been rebased on main at the time, thereby capturing the long term history.

- [Setup for Rockchip Programming](./docs/rockchip/README.md)
- [Setup for i.MX8 Programming](./docs/imx8/README.md)


## Add plugins to VSCode

* Docker
* Python
* CMake & CMake Tools
* Docker Explorer
* Cortex-Debug
* Remote - Containers
* Jupyter
* Better TOML


## SD Card Format

For development and debugging use an SD Card or USB stick. It must be partitioned,

- With MBR FAT32 (diskutil eraseDisk FAT32 ALPINE MBR $(DISK))
- 1Gb FAT32 boot partition
- 3.4Gb extFS 4 rootfs partition

An empty SD Card image is generated with `make ziloo-raw-image`, which will generate `ziloo-dev-card.img.zip`.


## Docker

The build and testing is run primarily in Docker. The firmware can be tested with QEMU in a dedicated docker container. Building the firmware also takes place in a Docker container. To rebuild the foundation docker containers run `make docker-push`. This will build and push docker images to Docker Hub. The password for
the ziloo docker hub user will be needed.

> sudo docker build --target base -t thepia/ziloo-base:v1 .
> sudo docker images

To open a builder shell run `docker compose run --rm builder-amd` or `docker compose run --rm builder-arm`.

Boards builds:

> docker compose run --rm builder-rv1109

## Building with one call:

> COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose up builder-rv1126-facial-gate 
> COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose up builder-rv1126-ai-uvc

or 

> COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose up builder-rv1109-facial-gate
> COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose up builder-rv1109-ai-uvc

or put both targets in the command.

For other targets see [docker-compose.yml](./docker-compose.yml).


## Alpine based

The main variant is based on [Alpine](https://alpinelinux.org/downloads/). It provides a clean based for reliable packaging. It has a [Build Infrastructure](https://gitlab.alpinelinux.org/alpine).
The Ziloo packages are built as .apk packages for this variant.

Alpine are made to run in memory so the storage can be removed while running. This means that it
has a higher memory footprint than OpenWRT, but it should be managable. Thread Stack = 80Kb.
Disk based boot, but not default. We will use [Data Disk Mode](https://wiki.alpinelinux.org/wiki/Installation#Data_Disk_Mode).

The install process for Raspberry Pi is ridicuously simple. Copy the files to a FAT formatted USB stick
or SD Card and use it!

- [Create a bootable SDHC from a Mac](https://wiki.alpinelinux.org/wiki/Create_a_bootable_SDHC_from_a_Mac)
- [Default password](https://techoverflow.net/2021/01/09/what-is-the-alpine-linux-default-login-password/)

The current build doesn't support

- Setup on SD Card (Do initial setup on USB)


## Supported platforms

- Raspberry Pi 3 running [Alpine Linux](https://alpinelinux.org/downloads/)
- Generic Arm running [Alpine Linux](https://alpinelinux.org/downloads/)


