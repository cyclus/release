#!/bin/bash
set -x 
set -e
./Miniconda-3.0.5-MacOSX-x86_64.sh -b -p ./anaconda
mv condarc $HOME/.condarc
anaconda/bin/conda install binstar
anaconda/bin/conda install conda-build
anaconda/bin/conda install jinja2
anaconda/bin/conda install setuptools
anaconda/bin/conda install xz 
#anaconda/bin/conda install libffi
anaconda/bin/conda build  --no-test --no-binstar-upload sigcpp
tar -czf results.tar.gz anaconda
exit 0
anaconda/bin/conda install sigcpp
anaconda/bin/conda install glibmm
anaconda/bin/conda  install libxmlpp
anaconda/bin/conda  install coincbc
anaconda/bin/conda install boost
anaconda/bin/conda install hdf5
anaconda/bin/conda install libxml2
anaconda/bin/conda install cmake
anaconda/bin/conda build --no-test --no-binstar-upload cyclus
tar -czf results.tar.gz anaconda

#anaconda/bin/conda install cyclus
ls -l anaconda
ls -l anaconda/bin
ls -l anaconda/share
