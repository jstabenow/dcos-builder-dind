# Building "DC/OS Build and Release tools" with Docker-in-Docker (dind)

## Based on

- https://github.com/dcos/dcos
- https://github.com/mesosphere/mesos-slave-dind

## Docker instructions

```sh
# clone repo
$ git clone https://github.com/jstabenow/dcos-builder-dind

# build docker image
$ docker build -t dcos-builder-dind .

# building dc/os
$ docker run -it --privileged -v $PWD/dcos-artifacts:/root/dcos-artifacts dcos-builder-dind

# building dc/os wirh custom config and location 
$ docker run -it \
    -v $PWD/dcos-artifacts:/root/dcos-artifacts \
    -v $PWD/myconfig:/myconfig \
    -e CONFIG_SHARED_PATH=/myconfig \
    --privileged dcos-builder-dind
```

## Builder (default) enviroments
More here: [DC/OS](https://github.com/dcos/dcos)

```sh
CONFIG_SHARED_PATH=/root/dcos-release.config.yaml
CONFIG_KIND=local_path
CONFIG_PREFERRED=local

RELEASE_ARTIFACTS_PATH=/root/dcos-artifacts
RELEASE_ACTION=create
RELEASE_CHANNEL=first
RELEASE_TAG=build-demo
```
