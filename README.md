# multi-arch-container-image

## Build

```bash
git clone https://github.com/openshift-examples/multi-arch.git
cd multi-arch
podman build -t quay.io/openshift-examples/multi-arch:$(uname -m) .
podman push --format v2s2 quay.io/openshift-examples/multi-arch:$(uname -m)
```

## Build/Create multi-arch image

```bash

podman manifest create mylist
podman pull quay.io/openshift-examples/multi-arch:aarch64
podman manifest add mylist quay.io/openshift-examples/multi-arch:aarch64
podman pull quay.io/openshift-examples/multi-arch:x86_64
podman manifest add mylist quay.io/openshift-examples/multi-arch:x86_64

podman manifest push mylist  docker://quay.io/openshift-examples/multi-arch:multi
Getting image list signatures
Copying 0 of 2 images in list
Writing manifest list to image destination
Storing list signatures
```

Just for information: 
 * [podman fails to push manifest-lists to quay.io #8242](https://github.com/containers/podman/issues/8242)
   
   **Please use `--all` at podman manifest push ...**


## Run

### on arch
```
aarch64 # podman run -ti --rm quay.io/openshift-examples/multi-arch:$(uname -m)
hello world from architecure: aarch64

aarch64 # podman run -ti --rm quay.io/openshift-examples/multi-arch:x86_64
{"msg":"exec container process `/usr/bin/container-entrypoint`: Exec format error","level":"error","time":"2020-10-27T09:30:44.000208134Z"}

```

### on x86
```
x86_64 # podman run -ti --rm quay.io/openshift-examples/multi-arch:$(uname -m)
hello world from architecure: x86_64

x86_64 # podman run -ti quay.io/openshift-examples/multi-arch:aarch64
{"msg":"exec container process `/usr/bin/container-entrypoint`: Exec format error","level":"error","time":"2020-10-27T09:30:59.000032763Z"}

```
