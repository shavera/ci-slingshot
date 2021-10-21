#!/usr/bin/env bash

docker_run_base(){
  docker run \
  -v "${PWD}":"${CONTAINER_REPO_DIR}" \
  -v "${LOCAL_BUILD_DIR}":"${CONTAINER_BUILD_DIR}" \
  -v "${LOCAL_COVERAGE_DIR}":"${CONTAINER_COVERAGE_DIR}" \
  -e SOURCE_DIR="${CONTAINER_SOURCE_DIR}" \
  -e BUILD_DIR="${CONTAINER_BUILD_DIR}" \
  -e COVERAGE_DIR="${CONTAINER_BUILD_DIR}" \
  -w "${CONTAINER_REPO_DIR}" \
  "$@" \
  local/ci-tooling
}