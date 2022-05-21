IMAGE_NAME=mariadb-backup-cron
VERSION=latest
#REGISTRY_TAG=docker.rgbhome.net/rgb/$(IMAGE_NAME):$(VERSION)
REGISTRY_TAG=rbender/$(IMAGE_NAME):$(VERSION)


.PHONY: build
build:
	docker build -t "$(IMAGE_NAME)" .
	docker image tag "$(IMAGE_NAME):$(VERSION)" "$(REGISTRY_TAG)"

.PHONY: push
push:
	docker image push "$(REGISTRY_TAG)"
