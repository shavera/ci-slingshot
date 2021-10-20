#!/usr/bin/env bash

if [[ -d "${LOCAL_COVERAGE_DIR}" ]]; then
  rm -rf "${LOCAL_COVERAGE_DIR}"
fi
mkdir -p "${LOCAL_COVERAGE_DIR}"

echo "00A"
ls "$PWD"
echo "00B"
ls "$PWD"/cpp
echo "00C"
echo "$LOCAL_BUILD_DIR"
echo "${LOCAL_BUILD_DIR}"
ls "$LOCAL_BUILD_DIR"
echo "00CC"
ls "${LOCAL_BUILD_DIR}"
echo "00CCC"
ls $LOCAL_BUILD_DIR
echo "00CCCC"
ls ${LOCAL_BUILD_DIR}
echo "00D"
ls "$LOCAL_COVERAGE_DIR"

docker run \
    -v "${PWD}":"${CONTAINER_REPO_DIR}" \
    -v "${LOCAL_BUILD_DIR}":"${CONTAINER_BUILD_DIR}" \
    -v "${LOCAL_COVERAGE_DIR}":"${CONTAINER_COVERAGE_DIR}" \
    -e SOURCE_DIR="${CONTAINER_SOURCE_DIR}" \
    -e BUILD_DIR="${CONTAINER_BUILD_DIR}" \
    -e COVERAGE_DIR="${CONTAINER_COVERAGE_DIR}" \
    -w "${CONTAINER_BUILD_DIR}" \
    --entrypoint "unit-test.sh" \
    shavera/ci-unit-test

echo "0A"
ls "$PWD"
echo "0B"
ls "$PWD"/cpp
echo "0C"
ls "$LOCAL_BUILD_DIR"
echo "0D"
ls "$LOCAL_COVERAGE_DIR"