default: build

build:
	docker build -t ziloo-image-builder --target ziloo-builder .

ziloo-raw-image: build
	docker run --rm --privileged -v $(shell pwd):/workspace ziloo-image-builder /scripts/raw/raw-sd-card.sh

shell: build
	docker run --rm -ti --privileged -v $(shell pwd):/workspace ziloo-image-builder bash

testshell: build
	docker run --rm -ti --privileged -v $(shell pwd)/scripts:/scripts -v $(shell pwd):/workspace ziloo-image-builder bash

tag:
	git tag ${TAG}
	git push origin ${TAG}