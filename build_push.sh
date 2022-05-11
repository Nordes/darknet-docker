#!/bin/bash

VERSION="0.4"

# for var in cpu cpu-noopt gpu gpu-cc53 gpu-cc60 gpu-cc61 gpu-cc62 gpu-cc70 gpu-cc72 gpu-cc75 gpu-cc80 gpu-cc86 \
#           cpu-cv cpu-noopt-cv gpu-cv gpu-cv-cc53 gpu-cv-cc60 gpu-cv-cc61 gpu-cv-cc62 gpu-cv-cc70 gpu-cv-cc72 gpu-cv-cc75 gpu-cv-cc80 gpu-cv-cc86
for var in gpu-cc75 cpu-go
do
  DOCKER_REPO="nordesbellnet/darknet"
  SOURCE_BRANCH="master"
  SOURCE_COMMIT=`git ls-remote https://github.com/AlexeyAB/darknet.git ${SOURCE_BRANCH} | awk '{ print $1 }'`
  DOCKER_TAG=$var
  VAR=$var

  echo $DOCKER_REPO
  echo $SOURCE_BRANCH
  echo $SOURCE_COMMIT
  echo $DOCKER_TAG
  echo $VAR

if [[ "$DOCKER_TAG" == *cv* ]]; then
  if [[ "$DOCKER_TAG" = *cpu-cv || "$DOCKER_TAG" = *cpu-noopt-cv ]]; then
    echo "building cpu-cv or cpu-noopt-cv"
    docker build \
      --build-arg CONFIG=$VAR \
      --build-arg SOURCE_BRANCH=$SOURCE_BRANCH \
      --build-arg SOURCE_COMMIT=$SOURCE_COMMIT \
      -t $DOCKER_REPO:$VERSION-$DOCKER_TAG -f Dockerfile.cpu-cv .
  else
    echo "building gpu-cv"
    docker build \
      --build-arg CONFIG=$VAR \
      --build-arg SOURCE_BRANCH=$SOURCE_BRANCH \
      --build-arg SOURCE_COMMIT=$SOURCE_COMMIT \
      -t $DOCKER_REPO:$VERSION-$DOCKER_TAG -f Dockerfile.gpu-cv .
  fi
 else
  if [[ "$DOCKER_TAG" = *cpu || "$DOCKER_TAG" = *cpu-noopt ]]; then
    echo "building cpu or cpu-noopt"
    docker build \
      --build-arg CONFIG=$VAR \
      --build-arg SOURCE_BRANCH=$SOURCE_BRANCH \
      --build-arg SOURCE_COMMIT=$SOURCE_COMMIT \
      -t $DOCKER_REPO:$VERSION-$DOCKER_TAG -f Dockerfile.cpu .
  elif [[ "$DOCKER_TAG" = *cpu-go || "$DOCKER_TAG" = *cpu-go-noopt ]]; then
    echo "building cpu-go or cpu-noopt-go"
    docker build \
      --build-arg CONFIG=$VAR \
      --build-arg SOURCE_BRANCH=$SOURCE_BRANCH \
      --build-arg SOURCE_COMMIT=$SOURCE_COMMIT \
      -t $DOCKER_REPO:$VERSION-$DOCKER_TAG -f Dockerfile.cpu-go .
  else
    echo "building gpu"
    docker build \
      --build-arg CONFIG=$VAR \
      --build-arg SOURCE_BRANCH=$SOURCE_BRANCH \
      --build-arg SOURCE_COMMIT=$SOURCE_COMMIT \
      -t $DOCKER_REPO:$VERSION-$DOCKER_TAG -f Dockerfile.gpu .
  fi
fi

docker push $DOCKER_REPO:$VERSION-$DOCKER_TAG
done
