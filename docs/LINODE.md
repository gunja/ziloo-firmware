# ziloo-builder-eu-central

This is an x86 Ubuntu 20.04LTS server hosted on Linode. It has 4GB RAM and 80GB SSD.

* IP 172.105.74.116 2a01:7e01::f03c:92ff:fec3:48bb

It should build the face gate and UVC AI images that you already have defined. But instead of manually, it should happen automatically with Continuous Integration via GitHub Actions.
All you have to do is
1) Install the GitHub Actions Runner package on this new server(LINODE.md)
2) Install docker
3) Configure build action for 4 docker build targets
4) Configure pulling/pushing from GitHub with SSH
5) Generate build artefacts to be accessed in Action results


## Connecting via SSH

> ssh root@172.105.74.116
> ssh -t thepia@lish-frankfurt.linode.com ziloo-builder-eu-central

Root pass: Jeg_er_håndværker



## Docker Support

The server must [support docker](https://bobcares.com/blog/linode-install-docker/) to run our builds.

The builds will also be Linux, but have dedicated configurations.


## GitHub Actions

An GitHub action must be triggered when the `[builder`](https://github.com/experientials/ziloo-firmware/tree/builder) branch is updated to build new firmware.

Initial clone can be done with

> git clone git@github.com:experientials/ziloo-firmware.git --recursive --branch builder

The builder server is registed with Github as an Actions Runner for the repository.
Need to add it as a [self-hosted runner](https://github.com/experientials/ziloo-firmware/settings/actions/runners). If you don't have access to Maintain the repository ask to be added to the "Build Supervisor" team.

I think it makes sense to keep the Git repository between builds. A working cache for Buildroot/Yocto can also be mapped so the `repo` commands can reuse past downloads.


## Builder script

It should run docker compose builds to create the firmware images.

* If it fails the logs are copied to /dist
* If it succeeds the images are copied to /dist
* After success the dist images are commited with "Firmware builder images" message and merged+pushed into the main branch.

In dist the target device has a dedicated directory. Hence `/dist/rv1109` and `/dist/rv1126` will hold the output.

Output logs and images must be linked in GitHub actions as build artifacts. Success/Fail status must be correct.

Large outputs must be compressed to be sure that the size is well below 50MB.

Steps in script(as it seems to me):

1) Git pull recursive and with force checkout(junk previous working directory)
2) Check out the builder branch
3) Use docker to run the builds
4) Do the builds for RV1109/RV1126 and both apps (Facial Gate will eventually be disabled)
5) Upon completion flag the build as completed/failed 
