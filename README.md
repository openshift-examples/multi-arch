# multi-arch-container-image

## Build on x86

```
s2i build \
  -e IMPORT_URL='github.com/openshift-examples/multi-arch-container-image' \
  git://github.com/openshift-examples/multi-arch-container-image \
  registry.access.redhat.com/ubi8/go-toolset:latest go-sample-app \
  --as-dockerfile Containerfile

podman build -t quay.io/openshift-examples/multi-arch-container-image:$(uname -m) .

$ podman run quay.io/openshift-examples/multi-arch-container-image:$(uname -m)
hello world from architecure: x86_64

podman push quay.io/openshift-examples/multi-arch-container-image:$(uname -m)
```

## Build on arm


https://github.com/openshift/source-to-image/issues/1008

```
git clone --single-branch --branch v1.3.1 https://github.com/openshift/source-to-image.git
cd source-to-image
dnf install -y golang btrfs-progs-devel device-mapper-devel
go build ./cmd/s2i
chmod +x s2i
mv s2i /usr/local/bin/

mkdir ~/hello-world
cd ~/hello-world


s2i build \
  -e IMPORT_URL='github.com/openshift-examples/multi-arch-container-image' \
  git://github.com/openshift-examples/multi-arch-container-image \
  registry.access.redhat.com/ubi8/go-toolset:latest go-sample-app \
  --as-dockerfile Containerfile

podman build -t quay.io/openshift-examples/multi-arch-container-image:$(uname -m) .

$ podman run quay.io/openshift-examples/multi-arch-container-image:$(uname -m)
hello world from architecure: aarch64

podman push quay.io/openshift-examples/multi-arch-container-image:$(uname -m)
```

## Build multiarch image
```


$ docker manifest create  quay.io/openshift-examples/multi-arch-container-image:latest quay.io/openshift-examples/multi-arch-container-image:x86_64 quay.io/openshift-examples/multi-arch-container-image:aarch64
$ docker manifest push quay.io/openshift-examples/multi-arch-container-image:latest
sha256:c754b6557c810ac514656be42541bfc5c75db216bdee22aa3feaa63b1027c48f


# podman manifest add registry.local/test registry.local:5000/demo/multi-arch-container-image:x86_64
fe873e19489252ae0956c6d46050728fe845cfd62fdcd4e9ada6e32176ded2f8
# podman manifest add registry.local/test registry.local:5000/demo/multi-arch-container-image:aarch64
fe873e19489252ae0956c6d46050728fe845cfd62fdcd4e9ada6e32176ded2f8
# podman manifest push --digestfile digest.txt registry.local/test docker://registry.local:5000/demo/multi-arch-container-image:latest
Getting image list signatures
Copying 0 of 2 images in list
Writing manifest list to image destination
Storing list signatures

curl -s https://registry.local:5000/v2/demo/multi-arch-container-image/manifests/$(cat digest.txt) | jq
{
  "schemaVersion": 2,
  "manifests": [
    {
      "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
      "digest": "sha256:a0c1a71dfbc44009fb357fefd9f190685cffaadd2b95fb23f4c867e4d7bb0e4c",
      "size": 1575,
      "platform": {
        "architecture": "amd64",
        "os": "linux"
      }
    },
    {
      "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
      "digest": "sha256:f12444761ec01afde051f3c921f7073af6001c91fa03fd8e38b8a04de03b11d7",
      "size": 1575,
      "platform": {
        "architecture": "arm64",
        "os": "linux"
      }
    }
  ]
}



# podman manifest create localhost/multi-arch-container-image-list
6ffbb68550f4c099ac102b8881d9ebf168b7acd293cf9de90a37652ee369c9e3

# podman manifest add localhost/multi-arch-container-image-list quay.io/openshift-examples/multi-arch-container-image:aarch64
6ffbb68550f4c099ac102b8881d9ebf168b7acd293cf9de90a37652ee369c9e3

# podman manifest add localhost/multi-arch-container-image-list quay.io/openshift-examples/multi-arch-container-image:x86_64
6ffbb68550f4c099ac102b8881d9ebf168b7acd293cf9de90a37652ee369c9e3

# podman manifest push localhost/multi-arch-container-image-list quay.io/openshift-examples/multi-arch-container-image:latest
Error: error pushing manifest localhost/multi-arch-container-image-list to quay.io/openshift-examples/multi-arch-container-image:latest: Invalid image name "quay.io/openshift-examples/multi-arch-container-image:latest", unknown transport "quay.io/openshift-examples/multi-arch-container-image"
# podman manifest push localhost/multi-arch-container-image-list docker://quay.io/openshift-examples/multi-arch-container-image:latest
Getting image list signatures
Copying 0 of 2 images in list
Writing manifest list to image destination
Error: error pushing manifest localhost/multi-arch-container-image-list to docker://quay.io/openshift-examples/multi-arch-container-image:latest: Uploading manifest list failed, attempted the following formats: application/vnd.oci.image.index.v1+json(Error uploading manifest latest to quay.io/openshift-examples/multi-arch-container-image: manifest invalid: manifest invalid), application/vnd.docker.distribution.manifest.list.v2+json(Error uploading manifest latest to quay.io/openshift-examples/multi-arch-container-image: manifest invalid: manifest invalid)

```


## Run

### on arch
```
aarch64 # podman run -ti quay.io/openshift-examples/multi-arch-container-image:aarch64
hello world from architecure: aarch64

aarch64 # podman run -ti quay.io/openshift-examples/multi-arch-container-image:x86_64
{"msg":"exec container process `/usr/bin/container-entrypoint`: Exec format error","level":"error","time":"2020-10-27T09:30:44.000208134Z"}



```

### on x86

```
x86_64 # podman run -ti quay.io/openshift-examples/multi-arch-container-image:aarch64
{"msg":"exec container process `/usr/bin/container-entrypoint`: Exec format error","level":"error","time":"2020-10-27T09:30:59.000032763Z"}

x86_64 # podman run -ti quay.io/openshift-examples/multi-arch-container-image:x86_64
hello world from architecure: x86_64


```
