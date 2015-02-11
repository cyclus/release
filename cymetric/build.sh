#!/bin/bash
export LD_LIBRARY_PATH=$PREFIX/lib/
export CMAKE_LIBRARY_PATH=$PREFIX/lib/
export PATH=$PREFIX/bin:$PATH
export DYLD_FALLBACK_LIBRARY_PATH=$PREFIX/lib/cyclus:$PREFIX/lib

ln -s $PREFIX/lib/libhdf5.so.9 $PREFIX/lib/libhdf5.so.8
ln -s $PREFIX/lib/libhdf5_hl.so.9 $PREFIX/lib/libhdf5_hl.so.8

$PREFIX/bin/cyclus --version
python setup.py install --prefix=$PREFIX --build-type=Release --hdf5=$PREFIX
