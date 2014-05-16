#!/bin/bash
set -x
set -e

MACOSX_DEPLOYMENT_TARGET=
export DYLD_LIBRARY_PATH=$PREFIX/lib
./configure --prefix=$PREFIX PKG_CONFIG=$PREFIX/bin/pkg-config PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PREFIX/lib/ PATH=$PATH:$PREFIX/bin/ CPPFLAGS=-I/$PREFIX/include LDFLAGS=-L/$PREFIX/lib
make
make install

