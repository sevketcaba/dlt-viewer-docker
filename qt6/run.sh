#!/bin/bash

set -e

build=0
while getopts "b" flag
do
    case "${flag}" in
    b) build=1;;
    esac
done

if [ ${build} -eq 1 ]
then
source build.sh
fi

xhost local:docker
docker run \
    --rm \
    -it \
    -e DISPLAY=${DISPLAY} \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /tmp:/tmp \
    -v /home/${whoami}/.cache/dlt-viewer:/root/.cache/dlt-viewer \
    -v /home/${whoami}:/host_home \
    --workdir /host_home \
    --network host \
    dlt-viewer:qt6