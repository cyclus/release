#!/bin/bash
#set -x 
#set -e
./configure --prefix=$PREFIX --disable-java  --enable-fast-install
make
#ls 
#mv bin $PREFIX/bin
#mv include $PREFIX/include
#mv lib $PREFIX/lib
#mv share $PREFIX/share
make install
rm -rf $PREFIX/share/doc/gettext/examples/
rm -rf $PREFIX/share/gettext/

