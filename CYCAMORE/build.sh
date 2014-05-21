set -x
set -e

export INSTALL=`pwd`/install

`pwd`/CYCLUS/build.sh
cd cycamore
mkdir build; cd build;
cmake ../ -DCMAKE_INSTALL_PREFIX=$INSTALL -DCYCLUS_ROOT_DIR=$INSTALL  -DCYCLOPTS_ROOT_DIR=$INSTALL -DCOIN_ROOT_DIR=$INSTALL -DBOOST_ROOT=$INSTALL -DBoost_NO_SYSTEM_PATHS=ON
make
make install
cd ../..
exit $?

