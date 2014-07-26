#!/bin/sh

set -e

if [ -z $4 ]; then
    echo "usage: ./make.sh <share_name> <login> <password> <max_size_in_mb>"
    exit 1
fi

NAME=$1
LOGIN=$2
PASSWORD=$3
MAX_SIZE=$4

cat Dockerfile.template | \
    sed "s/%name%/${NAME}/g" | \
    sed "s/%login%/${LOGIN}/g" | \
    sed "s/%password%/${PASSWORD}/g" | \
    sed "s/%max_size%/${MAX_SIZE}/g" \
    > Dockerfile

LOWER_NAME=$(echo "${NAME}" | tr '[:upper:]' '[:lower:]')

IMAGE="time-container-${LOWER_NAME}"

echo "building image ${IMAGE}"
docker build -t ${IMAGE} .

echo ">> run: docker run -d -p <docker_host_ip>:548:548 -v <docker_host_dir>:/share time-container-${LOWER_NAME}"
