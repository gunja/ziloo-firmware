default: build

build:
	docker build -t thepia/ziloo-runtime -f ./firmware.Dockerfile --target develop .
	docker build -t thepia/ziloo-runtime-x11 -f ./firmware.Dockerfile --target develop-x11 .

ziloo-runtime: build
	docker run --rm -ti --privileged thepia/ziloo-runtime /bin/sh

ziloo-runtime-vnc: build
	docker run -d --privileged -p 5900:5900 thepia/ziloo-runtime-x11
	docker ps

ziloo-runtime-rdp: build
	docker run -d --name rdp --shm-size 1g -p 3389:3389 thepia/ziloo-runtime

