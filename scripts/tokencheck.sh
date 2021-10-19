#!/usr/bin/env bash

if [[ -z "${SONAR_TOKEN}" ]]; then
  echo "No sonar token";
  exit 1;
else
  echo "Sonar token ${SONAR_TOKEN}";
fi