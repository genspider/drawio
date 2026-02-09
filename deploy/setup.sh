# 当前所在目录
workdir=$(dirname $(realpath $0))
set -x

patchdir=${workdir}/patches
mkdir -p ${patchdir}

version=`cat ${workdir}/../VERSION`
ls -al ${patchdir} | grep ${version}

git am < ${patchdir}/integration-${version}.patch
