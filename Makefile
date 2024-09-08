IMAGE=amadd0x/avorion-lgsm
VERSION=latest

build:
	docker buildx build --no-cache --progress=plain --platform=linux/amd64 -t $(IMAGE) .

shell:
	docker exec -it $(shell docker ps -lq) bash

run-local:
	docker run -d --rm \
		-p 27000:27000/udp \
		-p 27003:27003/udp \
		-p 27015:27015/tcp \
		-p 27020:27020/udp \
		-p 27021:27021/udp \
		$(IMAGE):$(VERSION)