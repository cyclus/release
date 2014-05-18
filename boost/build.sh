#!/bin/bash
echo $PATH
echo $CXX

MACOSX_DEPLOYMENT_TARGET=
export DYLD_LIBRARY_PATH=$PREFIX/lib
./bootstrap.sh
./bjam install --prefix=PREFIX
