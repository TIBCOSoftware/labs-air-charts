#!/bin/bash

mkdir -p ./archives

# shellcheck source=/dev/null
source .env

docker-compose pull || exit 1

docker save --output "./archives/dgraph-${DGRAPH_VERSION}.tar" "dgraph/dgraph:${DGRAPH_VERSION}" || exit 1

docker save --output "./archives/eclipse-mosquitto-${ECLIPSE_MOSQUITTO_VERSION}.tar" "eclipse-mosquitto:${ECLIPSE_MOSQUITTO_VERSION}" || exit 1

docker save --output "./archives/labs-air-ui-oss-${LABS_AIR_VERSION}.tar" "public.ecr.aws/tibcolabs/labs-air-ui-oss${ARCH}:${LABS_AIR_VERSION}" || exit 1

docker save --output "./archives/labs-air-data-mqtt-dgraph-${LABS_AIR_VERSION}.tar" "public.ecr.aws/tibcolabs/labs-air-data-mqtt-dgraph${ARCH}:${LABS_AIR_VERSION}" || exit 1

docker save --output "./archives/labs-air-metadata-mqtt-dgraph-${LABS_AIR_VERSION}.tar" "public.ecr.aws/tibcolabs/labs-air-metadata-mqtt-dgraph${ARCH}:${LABS_AIR_VERSION}" || exit 1

docker save --output "./archives/labs-air-notification-mqtt-dgraph-${LABS_AIR_VERSION}.tar" "public.ecr.aws/tibcolabs/labs-air-notification-mqtt-dgraph${ARCH}:${LABS_AIR_VERSION}" || exit 1

docker save --output "./archives/labs-air-pipeline-service-${LABS_AIR_VERSION}.tar" "public.ecr.aws/tibcolabs/labs-air-pipeline-service${ARCH}:${LABS_AIR_VERSION}" || exit 1

