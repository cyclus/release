#!/bin/bash

MACOSX_DEPLOYMENT_TARGET=

if [[  `uname` == 'Linux' ]]; then
./configure --prefix=$PREFIX 
else
export DYLD_LIBRARY_PATH=$PREFIX/lib
./configure --prefix=$PREFIX PKG_CONFIG=$PREFIX/bin/pkg-config PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PREFIX/lib/:/usr/local/lib PATH=$PATH:$PREFIX/bin/ CPPFLAGS=-I/$PREFIX/include LDFLAGS=-L/$PREFIX/lib
fi
make
make install

exit 0

