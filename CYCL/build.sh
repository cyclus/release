#!/bin/bash
set -x 
set -e

mv condarc $HOME/.condarc

if [[  `uname` == 'Linux' ]]; then
    chmod 755 Miniconda-3.0.5-Linux-x86_64.sh
    ./Miniconda-3.0.5-Linux-x86_64.sh -b -p ./anaconda
    anaconda/bin/conda install conda=3.6.1

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
    anaconda/bin/conda install conda=3.6.1

fi

anaconda/bin/conda search
anaconda/bin/conda install binstar  
if [[  `uname` == 'Linux' ]]; then
    anaconda/bin/conda install conda-build=1.6.1
else
    git clone https://github.com/conda/conda condaa
    cd condaa
    git checkout tags/3.6.1
    ../anaconda/bin/python setup.py install
    cd ..
    cd conda-build
    ../anaconda/bin/python setup.py install 
    cd ..
fi
anaconda/bin/conda install jinja2
anaconda/bin/conda install setuptools
anaconda/bin/conda build --no-test cyclus

#force cycamore to build with local cyclus
vers=`cat cyclus/meta.yaml | grep version`
read -a versArray <<< $vers

anaconda/bin/conda install --use-local cyclus=${versArray[1]}
tar -czf results.tar.gz anaconda

cp -r anaconda/conda-bld/work/tests cycltest
cp -r anaconda/conda-bld/work/release release

#build Doc
if [[  `uname` == 'Linux' ]]; then

cd anaconda/conda-bld/work/build
make cyclusdoc | tee  doc.out
line=`grep -i warning doc.out|wc -l`
if [ $line -ne 0 ]
 then
    exit 1
fi
ls -l
mv doc ../../../../cyclusdoc
cd ../../../..
fi

#Regression Testing
anaconda/bin/conda install nose
anaconda/bin/conda install numpy
anaconda/bin/conda install cython
anaconda/bin/conda install numexpr
anaconda/bin/conda install pytables

