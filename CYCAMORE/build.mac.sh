set -x
set -e

export INSTALL=`pwd`/install

export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:`pwd`/install/lib/

`pwd`/CYCLUS/build.mac.sh
cd cycamore
mkdir build; cd build;
cmake .. -DCMAKE_INSTALL_PREFIX=$INSTALL -DCYCLUS_ROOT_DIR=$INSTALL  -DCYCLOPTS_ROOT_DIR=$INSTALL -DCOIN_ROOT_DIR=$INSTALL -DBOOST_ROOT=$INSTALL
make
make install
cd ../..;
exit $?

