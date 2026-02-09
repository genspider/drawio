set -x
workdir=$(dirname "$(realpath "$0")")
ls -al "${workdir}/stencils/"
cp -r "${workdir}/stencils"/* "${rootdir}/src/main/webapp/stencils/"
