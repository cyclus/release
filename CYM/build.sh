#!/bin/bash
set -x 
set -e

./bin/conda-inst.sh
export PATH="$(pwd)/anaconda/bin:${PATH}"
UNAME=$(uname)
cymetric_tar_dir="cymetric-master"

# Build Cyclus, must happen before we set the workdir
anaconda/bin/conda build --no-test cymetric

# Setup workdir for later use
if [ -d "anaconda/conda-bld/work/${cymetric_tar_dir}" ]; then
  export WORKDIR="anaconda/conda-bld/work/${cymetric_tar_dir}"
else  
  export WORKDIR="anaconda/conda-bld/work"
fi

# force cyclus to build with local cymetric
vers=$(cat cymetric/meta.yaml | grep version)
read -a versArray <<< $vers

anaconda/bin/conda install --use-local cymetric=${versArray[1]}
tar -czf results.tar.gz anaconda

cp -r "${WORKDIR}/tests" cymtest
cp -r "${WORKDIR}/release" release

# Build Doc
if [[  "${UNAME}" == 'Linux' ]]; then
  origdir="$(pwd)"
  cd "${WORKDIR}/build"
  make cymetricdoc | tee  doc.out
  line=$(grep -i warning doc.out | wc -l)
  if [ $line -ne 0 ]; then
    exit 1
  fi
  ls -l
  mv doc "${origdir}/cymetricdoc"
  cd "$origdir"
fi

# Regression Testing
anaconda/bin/conda install nose
#anaconda/bin/conda install numpy
anaconda/bin/conda install cython
#anaconda/bin/conda install numexpr
#anaconda/bin/conda install pytables
