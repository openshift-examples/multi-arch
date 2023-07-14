#!/usr/bin/env bash


function __build {
    IMAGE="quay.io/openshift-examples/multi-arch:${GOOS}-${GOARCH}"

    echo "Build - ${IMAGE}"
    podman build --arch=$GOARCH --os=${GOOS} -f Containerfile.${GOOS} \
        -t $IMAGE . \

    echo "Push - ${IMAGE}"
    podman push $IMAGE


}

export GOOS=linux
for arch in amd64 arm64 ; do
    export GOARCH=$arch
    __build
done
