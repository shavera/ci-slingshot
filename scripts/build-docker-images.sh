#!/usr/bin/env bash

# halt if any command below fails
set -e

# NOTE, this is meant to be a guide to how to build these together, not necessarily run as a literal script
# It is meant to be run from the top level of the repo directory

## Step 1 - build
LOCAL_BUILD_DIR="${PWD}/ci-slingshot-build"
if [[ -d "${LOCAL_BUILD_DIR}" ]]; then
  rm -rf "${LOCAL_BUILD_DIR}"
fi
mkdir -p "${LOCAL_BUILD_DIR}"
CONTAINER_REPO_DIR="/usr/src/ci-slingshot"
CONTAINER_SOURCE_DIR="${CONTAINER_REPO_DIR}/cpp"
CONTAINER_BUILD_DIR="/usr/build/ci-slingshot"
docker run \
    -v "${PWD}":${CONTAINER_REPO_DIR} \
    -v "${LOCAL_BUILD_DIR}":${CONTAINER_BUILD_DIR} \
    -e SOURCE_DIR=${CONTAINER_SOURCE_DIR} \
    -e BUILD_DIR=${CONTAINER_BUILD_DIR} \
    shavera/ci-cmake-builder

printf "\nBuild complete\n"

## Step 2 - run tests
# can run tests inside new container from the same image
LOCAL_COVERAGE_DIR="${PWD}/ci-slingshot-coverage"
if [[ -d "${LOCAL_COVERAGE_DIR}" ]]; then
  rm -rf "${LOCAL_COVERAGE_DIR}"
fi
mkdir -p "${LOCAL_COVERAGE_DIR}"
CONTAINER_COVERAGE_DIR="/usr/sonar/ci-slingshot"
docker run -it\
    -v "${PWD}":${CONTAINER_REPO_DIR} \
    -v "${LOCAL_BUILD_DIR}":${CONTAINER_BUILD_DIR} \
    -v "${LOCAL_COVERAGE_DIR}":${CONTAINER_COVERAGE_DIR} \
    -e SOURCE_DIR=${CONTAINER_SOURCE_DIR} \
    -e BUILD_DIR=${CONTAINER_BUILD_DIR} \
    -e COVERAGE_DIR=${CONTAINER_COVERAGE_DIR} \
    -w ${CONTAINER_BUILD_DIR} \
    shavera/ci-unit-test

printf "\nTest complete\n"

## Step 3 - run sonarqube
docker run \
    -v "${PWD}":${CONTAINER_REPO_DIR} \
    -v "${LOCAL_BUILD_DIR}":${CONTAINER_BUILD_DIR} \
    -v "${LOCAL_COVERAGE_DIR}":${CONTAINER_COVERAGE_DIR} \
    -e SONAR_TOKEN="${SONAR_TOKEN}" \
    -e BUILD_DIR=${CONTAINER_BUILD_DIR} \
    -e COVERAGE_DIR=${CONTAINER_COVERAGE_DIR} \
    -w ${CONTAINER_REPO_DIR} \
    shavera/ci-sonar-scanner
