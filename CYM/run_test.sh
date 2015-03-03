#!/bin/bash
set -x 
set -e

export PATH="$(pwd)/anaconda/bin:${PATH}"
anaconda/bin/cyclus --install-path
anaconda/bin/cyclus --nuc-data
anaconda/bin/cyclus --version
which cymetric

which python
echo "subprocess ---- "
$(which python) -c "import subprocess; print(subprocess.__file__)"

cd cymtests
ls .
conda install nose
echo "PATH: ${PATH}"
echo "PYTHONPATH: $(python -c 'import sys; from pprint import pprint; pprint(sys.path)')"
echo "PYTHONPATH: $(python -c 'import cymetric; print(cymetric.__file__)')"
../anaconda/bin/nosetests -vs

exit $?
