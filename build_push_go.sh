#!/bin/bash

VERSION="0.4"
DOCKER_REPO="nordesbellnet/darknet"
DOCKER_TAG=gpu-cc75

docker build \
  -t $DOCKER_REPO:$DOCKER_TAG-$VERSION-go -f Dockerfile.go-enabled .

docker push $DOCKER_REPO:$DOCKER_TAG-$VERSION-go