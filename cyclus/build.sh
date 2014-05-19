#!/bin/bash
#export LD_LIBRARY_PATH=$PREFIX/lib/
#export CMAKE_LIBRARY_PATH=$PREFIX/lib/
#export PATH=$PREFIX/bin:$PATH


export LD_LIBRARY_PATH=$PREFIX/lib/
export CMAKE_LIBRARY_PATH=$PREFIX/lib/
export PATH=$PREFIX/bin:$PATH
if [[  `uname` == 'Linux' ]]; then

cmake  -DCMAKE_INSTALL_PREFIX=$PREFIX -DBOOST_ROOT=$PREFIX  -DBOOST_LIBRARYDIR=$PREFIX/lib -DBoost_NO_SYSTEM_PATHS=ON
make
make cyclusdoc
make install

else

MACOSX_DEPLOYMENT_TARGET=
export DYLD_LIBRARY_PATH=$PREFIX/lib

cmake  `pwd` -DCMAKE_INSTALL_PREFIX=$PREFIX -DCYCLOPTS_ROOT_DIR=$PREFIX -DCOIN_ROOT_DIR=$PREFIX -DBOOST_ROOT=$PREFIX
fi
make
make cyclusdoc
make install
