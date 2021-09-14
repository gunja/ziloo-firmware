# Firmware build instructions

Rockchip tools seem to generally rely on Ubuntu 18. This will have to do for now.

The `./boards/rockchip.Dockerfile` must contain stages that when completed (docker buildx) builds the firmware and demo apps.

> ./build.sh -?
> ./build.sh aio-rv1126-jd4.mk
> ./build.sh
