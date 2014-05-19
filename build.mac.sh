#!/bin/bash
set -x 
#set -e


if [[  `uname` == 'Linux' ]]; then
./Miniconda-3.0.5-Linux-x86_64.sh -b -p ./anaconda
mkdir install
cd  git
 make configure 
	 ./configure --prefix=`pwd`/../install
	 make
	 make install


cd ..
PATH=$PATH:`pwd`/install/bin
else
./Miniconda-3.0.5-MacOSX-x86_64.sh -b -p ./anaconda
fi
mv condarc $HOME/.condarc
anaconda/bin/conda install binstar
anaconda/bin/conda install conda-build
anaconda/bin/conda install jinja2
anaconda/bin/conda install setuptools
anaconda/bin/conda install xz 
#anaconda/bin/conda install libffi
#anaconda/bin/conda install sigcpp

#cd gettext-0.18.3
#mkdir `pwd`/../anaconda/gettext-0.18.3
#./configure --prefix=`pwd`/../anaconda/gettext-0.18.3
#make
#make install
#cd ..

anaconda/bin/conda build  --no-test --no-binstar-upload cyclus
tar -czf results.tar.gz anaconda
exit 0
anaconda/bin/conda install glibmm
anaconda/bin/conda  install libxmlpp
anaconda/bin/conda  install coincbc
anaconda/bin/conda install hdf5
anaconda/bin/conda install libxml2
anaconda/bin/conda install cmake
anaconda/bin/conda build --no-test --no-binstar-upload cyclus
tar -czf results.tar.gz anaconda

#anaconda/bin/conda install cyclus
ls -l anaconda
ls -l anaconda/bin
ls -l anaconda/share
