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
echo $CXX
anaconda/bin/conda build --no-test sigcpp
tar -czf results.tar.gz anaconda
