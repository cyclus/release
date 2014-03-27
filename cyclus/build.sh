#!/bin/bash
export LD_LIBRARY_PATH=$PREFIX/lib/
export CMAKE_LIBRARY_PATH=$PREFIX/lib/
export PATH=$PREFIX/bin:$PATH
echo HERE
echo $LD_LIBRARY_PATH
ls -l $PREFIX
ls -l $PREFIX/lib

cmake  -DCMAKE_INSTALL_PREFIX=$PREFIX -DBOOST_ROOT=$PREFIX  -DBOOST_LIBRARYDIR=$PREFIX/lib -DBoost_NO_SYSTEM_PATHS=ON
make
make cyclusdoc
make install
