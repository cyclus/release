set -x
set -e

`pwd`/CYCLUS/build.sh
cd cycamore
mkdir build
cd build
cmake ../ -DCMAKE_INSTALL_PREFIX=`pwd`/../../install -DCYCLUS_ROOT_DIR=`pwd`/../../install  -DCYCLOPTS_ROOT_DIR=`pwd`/../../install -DCOIN_ROOT_DIR=`pwd`/../../install -DBOOST_ROOT=`pwd`/../../install -DBoost_NO_SYSTEM_PATHS=ON

make
make install
cd ..
cd ..
exit $?

