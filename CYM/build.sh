#!/bin/bash
set -x 
set -e

./bin/conda-inst.sh
export PATH="$(pwd)/anaconda/bin:${PATH}"
UNAME=$(uname)
cymetric_tar_dir="cymetric-master"

# Build Cyclus, must happen before we set the workdir
anaconda/bin/conda install cyclus cycamore
if [[ "${UNAME}" == 'Linux' ]]; then
  ln -s $(pwd)/anaconda/lib/libhdf5.so.9 $(pwd)/anaconda/lib/libhdf5.so.8
  ln -s $(pwd)/anaconda/lib/libhdf5_hl.so.9 $(pwd)/anaconda/lib/libhdf5_hl.so.8
else
  ln -s $(pwd)/anaconda/lib/libhdf5.9.dylib $(pwd)/anaconda/lib/libhdf5.8.dylib
  ln -s $(pwd)/anaconda/lib/libhdf5_hl.9.dylib $(pwd)/anaconda/lib/libhdf5_hl.8.dylib
fi
which cyclus
cyclus --version
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

cp -r "${WORKDIR}/tests" cymtests
