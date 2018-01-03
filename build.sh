#!/bin/bash
set -e

source "version"

ARCH=${1:-$(uname -m)}
DIST="haproxy-${VERSION}"

function build {
  echo
  echo "+ build"
  echo "+ arch: ${ARCH:?}"
  echo "+ image: ${IMAGE:?}"
  echo "+ version: ${VERSION:?}"
  echo "+ dist: ${DIST:?}"
  echo

  export IMAGE
  export VERSION

  docker build \
    --pull \
    --build-arg "IMAGE=$IMAGE" \
    --build-arg "VERSION=$VERSION" \
    --build-arg "DIST=$DIST" \
    --tag "dalexandre/haproxy-$ARCH:$VERSION" \
    --tag "dalexandre/haproxy-$ARCH:latest" \
    .
}

function build-i386 {
  ARCH="i386"
  IMAGE="i386/haproxy:$VERSION-alpine"
  DIST="$DIST-linux-386"

  build
}

function build-amd64 {
  ARCH="amd64"
  IMAGE="amd64/haproxy:$VERSION-alpine"
  DIST="$DIST-linux-amd64"

  build
}

function build-aarch64 {
  ARCH="arm64v8"
  IMAGE="arm64v8/haproxy:$VERSION-alpine"
  DIST="$DIST-linux-arm64"

  build
}

function build-x86_64 {
  build-amd64
}

build-${ARCH:?}
