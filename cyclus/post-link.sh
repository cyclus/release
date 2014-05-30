#/bin/bash

mv $PREFIX/bin/cyclus $PREFIX/bin/cyclus_base
echo "
#!/bin/bash
if [[ ! -f ${PREFIX}/lib/liblapack.so.3gf ]]; then
ln -s \$(python -c \"import os.path as p; import numpy.linalg as l; print(p.join(p.split(l.__file__)[0], 'lapack_lite.*so'))\") ${PREFIX}/lib/liblapack.so.3gf
fi
export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib/cyclus
export DYLD_FALLBACK_LIBRARY_PATH=$PREFIX/lib/cyclus
export CYCLUS_NUC_DATA=$PREFIX/share/cyclus/cyclus_nuc_data.h5
export CYCLUS_PATH=$PREFIX/lib/cyclus
export CYCLUS_RNG_SCHEMA=$PREFIX/share/cyclus/cyclus.rng.in

$PREFIX/bin/cyclus_base \$*

" > $PREFIX/bin/cyclus
chmod 755 $PREFIX/bin/cyclus

mv $PREFIX/bin/cyclus_unit_tests $PREFIX/bin/cyclus_unit_tests_base
echo "
#!/bin/bash
if [[ ! -f ${PREFIX}/lib/liblapack.so.3gf ]]; then
ln -s \$(python -c \"import os.path as p; import numpy.linalg as l; print(p.join(p.split(l.__file__)[0], 'lapack_lite.*so'))\") ${PREFIX}/lib/liblapack.so.3gf
fi
export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib/cyclus
 export DYLD_FALLBACK_LIBRARY_PATH=$PREFIX/lib/cyclus
export CYCLUS_NUC_DATA=$PREFIX/share/cyclus/cyclus_nuc_data.h5
export CYCLUS_PATH=$PREFIX/lib/cyclus
export CYCLUS_RNG_SCHEMA=$PREFIX/share/cyclus/cyclus.rng.in

$PREFIX/bin/cyclus_unit_tests_base \$*

" > $PREFIX/bin/cyclus_unit_tests
chmod 755 $PREFIX/bin/cyclus_unit_tests

