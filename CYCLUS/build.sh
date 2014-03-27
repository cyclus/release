#!/bin/bash
set -x 
set -e
./Miniconda-3.0.5-Linux-x86_64.sh -b -p ./anaconda
mv condarc $HOME/.condarc
anaconda/bin/conda install binstar  
anaconda/bin/conda install conda-build 
anaconda/bin/conda install jinja2 
anaconda/bin/conda install patchelf 
anaconda/bin/conda install setuptools 
anaconda/bin/conda build --no-test --no-binstar-upload cyclus
anaconda/bin/conda install --use-local cyclus
tar -czf results.tar.gz anaconda

