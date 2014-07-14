#!/bin/bash
#find -exec touch \{\} \;
CFLAGS=
CXXFLAGS=
LDFLAGS=
CPPFLAGS=


 ARCH=
 SRC_DIR=
 RECIPE_DIR=
 PKG_NAME= 
 PKG_VERSION=
 PKG_BUILDNUM= 	
 PYTHON= 
 PY3K= 
 STDLIB_DIR= 
 SP_DIR= 	
 PY_VER= 
 SYS_PYTHON=
 SYS_PREFIX=

 LD_LIBRARY_PATH=
echo $MACOSX_DEPLOYMENT_TARGET
MACOSX_DEPLOYMENT_TARGET=
if [[  `uname` == 'Linux' ]]; then

./configure --prefix=$PREFIX --with-lapack="-L$PREFIX/lib/libblas.so -lblas"  --with-lapack="-L$PREFIX/lib/liblapack.so -llapack"
else

export LDFLAGS="-headerpad_max_install_names -headerpad"
export CFLAGS="-headerpad_max_install_names -headerpad"
./configure --prefix=$PREFIX # --with-blas=$PREFIX/lib/libblas.dylib  --with-lapack=$PREFIX/lib/liblapack.dylib
fi
make
make install


