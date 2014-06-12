#!/bin/bash
set -x 
set -e

`pwd`/CYCL/build.sh
PATH=$PATH:`pwd`/install/bin

anaconda/bin/conda build --no-test cycamore
anaconda/bin/conda install --use-local cycamore
#build Doc
if [[  `uname` == 'Linux' ]]; then

cd anaconda/conda-bld/work/build
make cycamoredoc | tee  doc.out
line=`grep -i warning doc.out|wc -l`
if [ $line -ne 0 ]
 then
    exit 1
fi
ls -l
mv doc ../../../../cycamoredoc
cd ../../../..


tar -czf results.tar.gz anaconda cyclusdoc cycamoredoc

else
tar -czf results.tar.gz anaconda 

fi


