#!/bin/bash
set -x 
set -e

`pwd`/CYCL/build.sh
PATH=$PATH:`pwd`/install/bin
anaconda/bin/conda list
# force cycamore to build with local cyclus
vers=`anaconda/bin/conda list | grep cyclus`
read -a versArray <<< $vers
if [[  `uname` == 'Linux' ]]; then
  sed -i  "s/- cyclus/- cyclus ${versArray[1]}/g" cycamore/meta.yaml
else
  sed -i '' "s/- cyclus/- cyclus ${versArray[1]}/g" cycamore/meta.yaml
fi

# force cycamore to build with local cyclus
vers=`cat cycamore/meta.yaml | grep version`
read -a versArray <<< $vers

anaconda/bin/conda build --no-test cycamore 
anaconda/bin/conda install --use-local cycamore=${versArray[1]}

cp -r anaconda/conda-bld/work/tests cycatest


# Build Docs
if [[  `uname` == 'Linux' ]]; then
  cd anaconda/conda-bld/work/build
  make cycamoredoc | tee  doc.out
  line=`grep -i warning doc.out|wc -l`
  if [ $line -ne 0 ]; then
    exit 1
  fi
  ls -l
  mv doc ../../../../cycamoredoc
  cd ../../../..
  tar -czf results.tar.gz anaconda cyclusdoc cycamoredoc
else
  tar -czf results.tar.gz anaconda 
fi


