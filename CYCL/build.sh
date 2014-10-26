#!/bin/bash
set -x 
set -e

./bin/conda-inst.sh
export PATH="$(pwd)/anaconda/bin:${PATH}"
UNAME=$(uname)

cyclus_tar_dir="cyclus-develop"
echo "#### Listing anaconda/conda-bld/work/${cyclus_tar_dir}"
ls -l "anaconda/conda-bld/work/${cyclus_tar_dir}"
echo "#### Listing PWD"
ls -l 
if [ -d "anaconda/conda-bld/work/${cyclus_tar_dir}" ]; then
  # Move everything up one directory
  # probably obtained from zip or tarball
  export WORKDIR="anaconda/conda-bld/work/${cyclus_tar_dir}"
else  
  export WORKDIR="anaconda/conda-bld/work"
fi

anaconda/bin/conda build --no-test cyclus

# force cycamore to build with local cyclus
vers=$(cat cyclus/meta.yaml | grep version)
read -a versArray <<< $vers

anaconda/bin/conda install --use-local cyclus=${versArray[1]}
tar -czf results.tar.gz anaconda

echo "#### ls work: ${WORKDIR}"
ls -1 "${WORKDIR}"
cp -rv "${WORKDIR}/tests" cycltest
cp -rv "${WORKDIR}/release" release

# Duild Doc
if [[  "${UNAME}" == 'Linux' ]]; then
  origdir="$(pwd)"
  cd "${WORKDIR}/build"
  make cyclusdoc | tee  doc.out
  line=$(grep -i warning doc.out | wc -l)
  if [ $line -ne 0 ]; then
    exit 1
  fi
  ls -l
  mv doc "${origdir}/cyclusdoc"
  cd "$origdir"
fi

# Regression Testing
anaconda/bin/conda install nose
anaconda/bin/conda install numpy
anaconda/bin/conda install cython
anaconda/bin/conda install numexpr
anaconda/bin/conda install pytables