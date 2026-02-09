#!/bin/bash
set -x

workdir=$(dirname "$(realpath "$0")")
patchdir="${workdir}/patches"
version=$(cat "${workdir}/../VERSION")

mkdir -p "${patchdir}"

# git format-patch -1 --stdout > "${patchdir}/integration-${version}.patch"
git diff --cached > "${patchdir}/integration-${version}.patch"

ls -al ${patchdir} | grep ${version}