#!/bin/bash
set -x 
set -e

if [[  `uname` == 'Linux' ]]; then
    chmod 755 Miniconda-3.0.5-Linux-x86_64.sh
    ./Miniconda-3.0.5-Linux-x86_64.sh -b -p ./anaconda
    anaconda/bin/conda install patchelf
    cd  git
    make configure 
	 ./configure --prefix=`pwd`/../install
	 make
	 make install
    cd ..
    PATH=$PATH:`pwd`/install/bin
else
    chmod 755 Miniconda-3.0.5-MacOSX-x86_64.sh
    ./Miniconda-3.0.5-MacOSX-x86_64.sh -b -p ./anaconda
fi

mv condarc $HOME/.condarc
anaconda/bin/conda install binstar  
anaconda/bin/conda install conda-build 
anaconda/bin/conda install jinja2 
anaconda/bin/conda install setuptools 
anaconda/bin/conda build --no-test cyclus
anaconda/bin/conda install --use-local cyclus
tar -czf results.tar.gz anaconda
