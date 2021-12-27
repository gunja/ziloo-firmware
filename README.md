# Ziloo Firmware

Ziloo is an independent device that sees and senses the environment. It recognises objects and behavior based on what it has been taught. It outputs an event log describing what is perceived.

The firmware is loosely Linux based. The essential parts are bundled as packages to be run in an
embedded Posix environment.

Key building blocks are:

- Log based storage
- muslc static library
- busybox shell
- Base Firmware from read-only squashfs
- [F2FS](https://www.kernel.org/doc/html/latest/filesystems/f2fs.html) storage (requires Linux Kernel 5.7)

Further instructions,

- [Setting up Development environment](./docs/DEVELOP.md)
- [Continuous Integration](./docs/CONTINUOUS_INTEGRATION.md)
- [SD Card Format](./docs/DEVELOP.md#SD_Card_Format)
- [Building with Docker](./docs/DEVELOP.md#SD_Card_Format#Docker)
- [Alpine based](./docs/DEVELOP.md#SD_Card_Format#Alpine_based)
- [i.MX8 Yocto Docs](./docs/imx8/README.md)



## Windows Programming Machine

Things to install

* [Adroid SDK Platform Tools](https://developer.android.com/studio/releases/platform-tools)
* [Docker Desktop on Windows](https://www.docker.com/products/docker-desktop)
* [Git for Windows](gitforwindows.org)

Open powershell in the `platform-tools` folder. Run adb commands with `adb.exe`.


## macOS Programming Machine

For Rockchip [Setup for Rockchip Programming](./docs/rockchip/README.md)

Possible fix on Big Sur x86: install autoconf 2.69 manually, not with homebrew
