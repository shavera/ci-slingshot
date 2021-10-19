#!/usr/bin/env bash

if [[ -d "${LOCAL_COVERAGE_DIR}" ]]; then
  rm -rf "${LOCAL_COVERAGE_DIR}"
fi
mkdir -p "${LOCAL_COVERAGE_DIR}"

docker run \
    -v "${PWD}":${CONTAINER_REPO_DIR} \
    -v "${LOCAL_BUILD_DIR}":${CONTAINER_BUILD_DIR} \
    -v "${LOCAL_COVERAGE_DIR}":${CONTAINER_COVERAGE_DIR} \
    -e SOURCE_DIR=${CONTAINER_SOURCE_DIR} \
    -e BUILD_DIR=${CONTAINER_BUILD_DIR} \
    -e COVERAGE_DIR=${CONTAINER_COVERAGE_DIR} \
    -w ${CONTAINER_BUILD_DIR} \
    --entrypoint "unit-test.sh" \
    shavera/ci-unit-test