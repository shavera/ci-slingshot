#!/usr/bin/env bash

# NOTE, this is meant to be a guide to how to build these together, not necessarily run as a literal script
# It is meant to be run from the top level of the repo directory

## Step 0 - preconditions
docker build . -t local/project-base -f docker/project-base.Dockerfile
docker build . -t local/project-builder -f docker/builder.Dockerfile

## Step 1 - build
LOCAL_BUILD_DIR="${PWD}/../ci-slingshot-build"
if [[ -d "${LOCAL_BUILD_DIR}" ]]; then
  rm -rf ${LOCAL_BUILD_DIR}
fi
mkdir -p ${LOCAL_BUILD_DIR}
CONTAINER_REPO_DIR="/usr/src/ci-slingshot"
CONTAINER_SOURCE_DIR="${CONTAINER_REPO_DIR}/cpp"
CONTAINER_BUILD_DIR="/usr/build/ci-slingshot"
docker run \
    -v ${PWD}:${CONTAINER_REPO_DIR} \
    -v ${LOCAL_BUILD_DIR}:${CONTAINER_BUILD_DIR} \
    -e SOURCE_DIR=${CONTAINER_SOURCE_DIR} \
    -e BUILD_DIR=${CONTAINER_BUILD_DIR} \
    --user "$(id -u)":"$(id -g)" \
    local/project-builder

echo "\nBuild complete\n"

## Step 2 - run tests
# can run tests inside new container from the same image
docker run \
    -v ${PWD}:${CONTAINER_REPO_DIR} \
    -v ${LOCAL_BUILD_DIR}:${CONTAINER_BUILD_DIR} \
    -e SOURCE_DIR=${CONTAINER_SOURCE_DIR} \
    -e BUILD_DIR=${CONTAINER_BUILD_DIR} \
    --user "$(id -u)":"$(id -g)" \
    -w ${CONTAINER_BUILD_DIR} \
    --entrypoint "ctest" \
    local/project-builder

echo "\nTest complete\n"

## Step 3 - run sonarqube

