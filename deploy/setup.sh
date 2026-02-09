#!/bin/bash
set -x

workdir=$(dirname "$(realpath "$0")")
patchdir="${workdir}/patches"
version=$(cat "${workdir}/../VERSION")

mkdir -p "${patchdir}"

# 确保 patch 存在
if [[ ! -f "${patchdir}/integration-${version}.patch" ]]; then
  echo "ERROR: Patch file not found: integration-${version}.patch" >&2
  exit 1
fi

# 设置 Git 用户身份（必须！）
git config user.name "Render CI"
git config user.email "ci@render.invalid"

# 应用 patch
git apply < "${patchdir}/integration-${version}.patch"