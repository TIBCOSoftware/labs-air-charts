#!/bin/bash

source .env

docker load --input ./archives/dgraph-${DGRAPH_VERSION}.tar

docker load --input ./archives/eclipse-mosquitto-${ECLIPSE_MOSQUITTO_VERSION}.tar

docker load --input ./archives/labs-air-ui-oss-${LABS_AIR_VERSION}.tar

docker load --input ./archives/labs-air-data-mqtt-dgraph-${LABS_AIR_VERSION}.tar

docker load --input ./archives/labs-air-metadata-mqtt-dgraph-${LABS_AIR_VERSION}.tar

docker load --input ./archives/labs-air-notification-mqtt-dgraph-${LABS_AIR_VERSION}.tar

docker load --input ./archives/labs-air-pipeline-service-${LABS_AIR_VERSION}.tar

