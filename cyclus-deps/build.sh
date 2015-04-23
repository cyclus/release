#!/bin/bash

# # hack fix for hdf5 issues
# if [[ "${UNAME}" == 'Linux' ]]; then
#   ln -s $PREFIX/lib/libhdf5.so.9 $PREFIX/lib/libhdf5.so.8
#   ln -s $PREFIX/lib/libhdf5_hl.so.9 $PREFIX/lib/libhdf5_hl.so.8
# else
#   ln -s $PREFIX/lib/libhdf5.9.dylib $PREFIX/lib/libhdf5.8.dylib
#   ln -s $PREFIX/lib/libhdf5_hl.9.dylib $PREFIX/lib/libhdf5_hl.8.dylib
# fi

echo DONE
