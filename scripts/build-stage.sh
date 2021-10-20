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
   shavera/ci-cmake-builder

echo "000A"
ls "$PWD"
echo "000B"
ls "$PWD"/cpp
echo "000C"
echo "${LOCAL_BUILD_DIR}"
ls "$LOCAL_BUILD_DIR"
if [[ -d "${LOCAL_BUILD_DIR}" ]]; then
  echo "build dir found"
  pushd "$LOCAL_BUILD_DIR" || exit 1
  ls .
  popd || exit 1
else
  echo "No build dir found"
fi
echo "000CC"
ls "${LOCAL_BUILD_DIR}"