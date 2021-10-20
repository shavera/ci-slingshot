#!/usr/bin/env bash

docker run \
    -v "${PWD}":${CONTAINER_REPO_DIR} \
    -v "${LOCAL_BUILD_DIR}":${CONTAINER_BUILD_DIR} \
    -v "${LOCAL_COVERAGE_DIR}":${CONTAINER_COVERAGE_DIR} \
    -e SONAR_TOKEN="${SONAR_TOKEN}" \
    -e BUILD_DIR=${CONTAINER_BUILD_DIR} \
    -e COVERAGE_DIR=${CONTAINER_COVERAGE_DIR} \
    -w ${CONTAINER_REPO_DIR} \
    shavera/ci-sonar-scanner