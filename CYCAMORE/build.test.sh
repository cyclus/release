set -x
set -e

`pwd`/CYCLUS/build.test.sh
cd cycamore
mkdir build
cd build
cmake ../src -DCMAKE_INSTALL_PREFIX=`pwd`/../../install -DCYCLUS_ROOT_DIR=`pwd`/../../install  -DCYCLOPTS_ROOT_DIR=`pwd`/../../install -DCOIN_ROOT_DIR=`pwd`/../../install -DBOOST_ROOT=`pwd`/../../install
make
make install
cd ..
cd ..

tar -czf results.tar.gz cyclus cycamore

exit $?

