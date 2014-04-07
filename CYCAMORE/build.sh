set -x
set -e

`pwd`/CYCLUS/build.sh
cd cycamore
mkdir build
cd build
cmake ../ -DCMAKE_INSTALL_PREFIX=`pwd`/../../install -DCYCLUS_ROOT_DIR=`pwd`/../../install  -DCYCLOPTS_ROOT_DIR=`pwd`/../../install -DCOIN_ROOT_DIR=`pwd`/../../install -DBOOST_ROOT=`pwd`/../../install
make
make install
cd ..
cd ..
mkdir -p `pwd`/install/lib/python2.7/site-packages
export PYTHONPATH=$PYTHONPATH:`pwd`/install:`pwd`/install/lib/python2.7/site-packages
cd nose
python setup.py install --prefix=`pwd`/../install
cd ../numpy
python setup.py install --prefix=`pwd`/../install
cd ../cython
python setup.py install --prefix=`pwd`/../install
cd ../numexpr
python setup.py install --prefix=`pwd`/../install
cd ../PyTables
python setup.py install --prefix=`pwd`/../install --hdf5=`pwd`/../install
cd ..
exit $?

