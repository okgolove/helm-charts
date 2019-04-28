IMAGE_NAME ?= okgolove/helm-testing
IMAGE_TAG ?= 2.13.1

.PHONY: all build release

build:
	docker build --rm --build-arg HELM_VERSION=$(IMAGE_TAG) -t $(IMAGE_NAME):$(IMAGE_TAG) -t $(IMAGE_NAME):latest .

release:
	docker push $(IMAGE_NAME):$(IMAGE_TAG)
	docker push $(IMAGE_NAME):latest

all: build release
	@echo 'Finished ...'
