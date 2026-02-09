# 当前所在目录
workdir=$(dirname $(realpath $0))
set -x

patchdir=${workdir}/patches
mkdir -p ${patchdir}

version=`cat ${workdir}/../VERSION`
git format-patch -1 --stdout > ${patchdir}/integration-${version}.patch

ls -al ${patchdir} | grep ${version}