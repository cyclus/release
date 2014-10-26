#!/bin/bash
set -x 
set -e

./bin/conda-inst.sh
export PATH="$(pwd)/anaconda/bin:${PATH}"

anaconda/bin/conda build --no-test cyclus

# force cycamore to build with local cyclus
vers=`cat cyclus/meta.yaml | grep version`
read -a versArray <<< $vers

anaconda/bin/conda install --use-local cyclus=${versArray[1]}
tar -czf results.tar.gz anaconda

echo "#### ls work"
ls -1 anaconda/conda-bld/work
cp -rv anaconda/conda-bld/work/tests cycltest
cp -rv anaconda/conda-bld/work/release release

# Duild Doc
if [[  `uname` == 'Linux' ]]; then
  cd anaconda/conda-bld/work/build
  make cyclusdoc | tee  doc.out
  line=`grep -i warning doc.out|wc -l`
  if [ $line -ne 0 ]; then
    exit 1
  fi
  ls -l
  mv doc ../../../../cyclusdoc
  cd ../../../..
fi

# Regression Testing
anaconda/bin/conda install nose
anaconda/bin/conda install numpy
anaconda/bin/conda install cython
anaconda/bin/conda install numexpr
anaconda/bin/conda install pytables