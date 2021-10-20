#!/usr/bin/env bash

if [[ -d "${LOCAL_BUILD_DIR}" ]]; then
  rm -rf "${LOCAL_BUILD_DIR}"
fi
mkdir -p "${LOCAL_BUILD_DIR}"
echo "Build stage: ${LOCAL_BUILD_DIR} -- ${CONTAINER_BUILD_DIR}"
docker run \
    -v "${PWD}":${CONTAINER_REPO_DIR} \
    -v BuildDir:${CONTAINER_BUILD_DIR} \
    -e SOURCE_DIR=${CONTAINER_SOURCE_DIR} \
    -e BUILD_DIR=${CONTAINER_BUILD_DIR} \
   shavera/ci-cmake-builder

echo "Build complete: local build dir contents: "
ls "${LOCAL_BUILD_DIR}"