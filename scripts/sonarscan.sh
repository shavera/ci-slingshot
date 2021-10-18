#!/usr/bin/env bash

if [[ -z "${SONAR_TOKEN}" ]]; then
  echo "No environment variable named SONAR_TOKEN. Cannot scan."
  exit 1
else
  sonar-scanner \
      --define sonar.host.url="${SONAR_SERVER_URL}" \
      --define sonar.cfamily.build-wrapper-output="${BUILD_WRAPPER_OUT_DIR}" \
      --define sonar.coverageReportPaths="${BUILD_WRAPPER_OUT_DIR}/coverage.xml"
fi