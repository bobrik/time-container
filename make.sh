#!/bin/sh

set -e

if [ -z $3 ]; then
    echo "usage: ./make.sh share_name login password"
    exit 1
fi

NAME=$1
LOGIN=$2
PASSWORD=$3

cat Dockerfile.template | \
    sed "s/%name%/${NAME}/g" | \
    sed "s/%login%/${LOGIN}/g" | \
    sed "s/%password%/${PASSWORD}/g" \
    > Dockerfile

LOWER_NAME=$(echo "${NAME}" | tr '[:upper:]' '[:lower:]')

IMAGE="time-container-${LOWER_NAME}"

echo "building image ${IMAGE}"
docker build -t ${IMAGE} .

echo ">> run: docker run -d -p <docker_host_ip>:548:548 -v <docker_host_dir>:/share time-container-<share_name>"
