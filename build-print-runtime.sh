#!/usr/bin/env bash



function __build {
    echo "Build print-runtime-${GOOS}-${GOARCH}.."
    podman run -ti --user 0 --rm -e GO111MODULE=off \
        -v $(pwd):/work:z --workdir /work --entrypoint go \
        -e GOOS=${GOOS} -e GOARCH=${GOARCH} \
         registry.access.redhat.com/ubi9/go-toolset \
            build -o print-runtime-${GOOS}-${GOARCH} print-runtime.go;

}

export GOOS=linux
for arch in amd64 arm64 ; do 
    export GOARCH=$arch
    __build
done


export GOOS=windows
export GOARCH=amd64
__build



