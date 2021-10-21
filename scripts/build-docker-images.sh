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
#may need to export `CONTAINER_X_DIR` vars
CONTAINER_REPO_DIR="/usr/src/ci-slingshot"
CONTAINER_SOURCE_DIR="${CONTAINER_REPO_DIR}/cpp"
CONTAINER_BUILD_DIR="/usr/build/ci-slingshot"

LOCAL_COVERAGE_DIR="${PWD}/ci-slingshot-coverage"
if [[ -d "${LOCAL_COVERAGE_DIR}" ]]; then
  rm -rf "${LOCAL_COVERAGE_DIR}"
fi
mkdir -p "${LOCAL_COVERAGE_DIR}"
CONTAINER_COVERAGE_DIR="/usr/sonar/ci-slingshot"

source "$(dirname "${BASH_SOURCE[0]}")/docker_run_base.sh"

docker_run_base -e BUILD_PHASE="BUILD"

printf "\nBuild complete\n"

docker_run_base -e BUILD_PHASE="TEST"

printf "\nTest complete\n"

docker_run_base -e BUILD_PHASE="SCAN" -e SONAR_TOKEN="${SONAR_TOKEN}"
