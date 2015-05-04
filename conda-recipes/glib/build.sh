#!/bin/bash
set -x
set -e
#exec  2>&1

#mv ../../../../pkg-config-lite-0.28-1 .
#cd pkg-config-lite-0.28-1
#./configure --prefix=$PREFIX
#make
#make install
#cd ..

#mv ../../../../libffi-3.0.13 .
#cd libffi-3.0.13
#./configure --prefix=$PREFIX
#make
#make install
#cd ..

#mv ../../../../gettext-0.18.3 .
#cd gettext-0.18.3
#./configure --prefix=$PREFIX
#make 
#make install
#cd ..

#MACOSX_DEPLOYMENT_TARGET=
#echo $DYLD_LIBRARY_PATH
#OSX_ARCH=
#CFLAGS=" -g -O2 "
#CXXFLAGS=" -g -O2 "
#PATH=${PATH/$PREFIX\/bin:/}
#PATH=$PATH:$PREFIX/bin
#PKG_CONFIG_PATH=
#./configure -h
export DYLD_LIBRARY_PATH=$PREFIX/lib
./configure --prefix=$PREFIX PKG_CONFIG=$PREFIX/bin/pkg-config PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig   LD_LIBRARY_PATH=/$PREFIX/lib/  CPPFLAGS=-I/$PREFIX/include LDFLAGS=-L/$PREFIX/lib
make
make install


