#!/usr/bin/env sh

set -e

repo="${1}"
branch="${2}"

target_config="/config"

probe_config_file="${target_config}/configuration.yaml"

if [ ! -e "${probe_config_file}" ]; then
  echo "Configuration does not exist, cloning it ..."
  tmp_config="/tmp/config"
  mkdir "${tmp_config}"
  git clone --branch "${branch}" --single-branch -- "${repo}" "${tmp_config}"

  cd "${tmp_config}" || exit 1

  export target_config
  # no ".git", .gitignore etc
  find . -not  \( -path './.git*' -prune \) -type f -exec sh -c '
    f="${1}"
    dir="${f%/*}"
		mkdir --parents "${target_config}/${dir}"
		cp "${f}" "${target_config}/${f}" -v
' shell {} \;
else
  echo "Configuration exists already"
fi

echo "done"