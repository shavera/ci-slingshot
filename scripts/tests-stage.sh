#!/usr/bin/env bash

if [[ -d "${LOCAL_COVERAGE_DIR}" ]]; then
  rm -rf "${LOCAL_COVERAGE_DIR}"
fi
mkdir -p "${LOCAL_COVERAGE_DIR}"
docker run \
    -v "${PWD}":"${CONTAINER_REPO_DIR}" \
    -v "${LOCAL_BUILD_DIR}":"${CONTAINER_BUILD_DIR}" \
    -v "${LOCAL_COVERAGE_DIR}":"${CONTAINER_COVERAGE_DIR}" \
    -e BUILD_DIR="${CONTAINER_BUILD_DIR}" \
    -e COVERAGE_DIR="${CONTAINER_COVERAGE_DIR}" \
    -e BUILD_PHASE="TEST" \
    -w "${CONTAINER_REPO_DIR}" \
    shavera/ci-unit-test