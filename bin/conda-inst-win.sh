#!/bin/bash
# THIS FAILS BECAUSE MINICONDA INSTALLATION IS BROKEN!!
# Installs conda locally
set -x 
set -e

# Setup
UNAME=$(uname)
MINICONDA_VER="3.7.0"
export PATH="$(pwd)/anaconda/bin:${PATH}"
MINICONDA="Miniconda-${MINICONDA_VER}-Windows-x86_64.zip"

# Install
mv condarc $HOME/.condarc
#unzip ${MINICONDA} # unzip not on batlab
python -c "from zipfile import ZipFile; f = ZipFile('${MINICONDA}', 'r'); f.extractall(); f.close()"
echo "############ ls "
ls
echo "############ ls $(pwd)"
ls $(pwd)
echo "############ dollarPATH = $PATH"
echo "############ conda -V"
conda -V
echo "############ conda info"
conda info

#conda install conda=3.6.1  # is this needed?
conda update conda
conda install jinja2
conda install setuptools
conda install binstar  
conda install conda-build
