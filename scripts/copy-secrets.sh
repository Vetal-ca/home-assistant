#!/usr/bin/env sh

set -e

target_config="/config"
target_file="${target_config}/secrets.yaml"

if [ -f "${target_file}" ]; then
  echo "File \"${target_file}\" exists already, skipping the copy over"
else
  echo "Copying deployed secrets to \"${target_config}\" directory"
  cp "/secrets/secrets.yaml" "${target_config}" -v
fi