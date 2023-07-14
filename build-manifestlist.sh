#!/usr/bin/env bash

podman manifest create manifestlist/v1
podman manifest add manifestlist/v1 quay.io/openshift-examples/multi-arch:linux-amd64
podman manifest add manifestlist/v1 quay.io/openshift-examples/multi-arch:linux-arm64
podman manifest push manifestlist/v1  docker://quay.io/openshift-examples/multi-arch:main
podman manifest rm manifestlist/v1