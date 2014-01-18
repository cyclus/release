set -x
set -e

`pwd`/CYCLUS/build.mac.sh
cd cycamore
cmake src -DCMAKE_INSTALL_PREFIX=`pwd`/../install -DCYCLUS_ROOT_DIR=`pwd`/../install  -DCYCLOPTS_ROOT_DIR=`pwd`/../install -DCOIN_ROOT_DIR=`pwd`/../install -DBOOST_ROOT=`pwd`/../install
make
make install
cd ..
cd nose
export PYTHONPATH=$PYTHONPATH:`pwd`/../install/lib/python2.7/site-packages
mkdir -p `pwd`/../install/lib/python2.7/site-packages
python setup.py install --prefix=`pwd`/../install
cd ..
exit $?

