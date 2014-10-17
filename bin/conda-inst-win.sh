#!/bin/bash
# THIS FAILS BECAUSE MINICONDA INSTALLATION IS BROKEN!!
# Installs conda locally
set -x 
set -e

# Setup
UNAME=$(uname)
MINICONDA_VER="3.7.0"
export PATH="$(pwd)/anaconda/bin:${PATH}:C:\\anaconda\\bin"
MINICONDA="Miniconda-${MINICONDA_VER}-Windows-x86_64.exe"
export PATH="$HOME\\Python\\Scripts:$PATH"

# Install
mv condarc $HOME/.condarc
chmod 755 ${MINICONDA}
./${MINICONDA} /S /D=C:\\anaconda
sleep 1m
echo "############ dir C:\\ "
dir C:\\
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
