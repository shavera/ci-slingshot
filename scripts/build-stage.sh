#!/usr/bin/env bash

if [[ -d "${LOCAL_BUILD_DIR}" ]]; then
  rm -rf "${LOCAL_BUILD_DIR}"
fi
mkdir -p "${LOCAL_BUILD_DIR}"
docker run \
    -v "${PWD}":"${CONTAINER_REPO_DIR}" \
    -v "${LOCAL_BUILD_DIR}":"${CONTAINER_BUILD_DIR}" \
    -e SOURCE_DIR="${CONTAINER_SOURCE_DIR}" \
    -e BUILD_DIR="${CONTAINER_BUILD_DIR}" \
    -e BUILD_PHASE="BUILD" \
    -w "${CONTAINER_REPO_DIR}" \
   shavera/ci-cmake-builder
