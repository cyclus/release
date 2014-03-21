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
anaconda/bin/conda build --no-test cycamore
anaconda/bin/conda install --use-local cycamore
tar -czf results.tar.gz anaconda

#anaconda/bin/conda install cyclus
ls -l anaconda
ls -l anaconda/bin
ls -l anaconda/share
