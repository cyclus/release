#!/bin/bash
set -x
set -e


if [[  `uname` == 'Linux' ]]; then
   ./configure --prefix=$PREFIX  PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
else

   MACOSX_DEPLOYMENT_TARGET=
   export DYLD_LIBRARY_PATH=$PREFIX/lib
   ./configure --prefix=$PREFIX PKG_CONFIG=$PREFIX/bin/pkg-config PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PREFIX/lib/ PATH=$PATH:$PREFIX/bin/ CPPFLAGS=-I/$PREFIX/include LDFLAGS=-L/$PREFIX/lib
fi
make
make install

