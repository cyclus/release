#!/bin/bash
# Installs conda locally
set -x 
set -e

# Setup
UNAME=$(uname)
MINICONDA_VER="3.70"
export PATH="$(pwd)/anaconda/bin:${PATH}"

if [[  "$UNAME" == 'Linux' ]]; then
  MINICONDA="Miniconda-${MINICONDA_VER}-Linux-x86_64.sh"
else
  MINICONDA="Miniconda-${MINICONDA_VER}-MacOSX-x86_64.sh"
fi

# Install
mv condarc $HOME/.condarc
chmod 755 ${MINICONDA}
./${MINICONDA} -b -p ./anaconda
conda install conda=3.6.1  # is this needed?
conda install jinja2
conda install setuptools
conda install patchelf
conda install git
conda install binstar  
conda install conda-build
