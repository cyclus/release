set -x
set -e

export MYISNTALL=`pwd`/install

export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:`pwd`/install/lib/

`pwd`/CYCLUS/build.mac.sh
cd cycamore
mkdir build; cd build;
cmake .. -DCMAKE_INSTALL_PREFIX=$MYISNTALL -DCYCLUS_ROOT_DIR=$MYISNTALL  -DCYCLOPTS_ROOT_DIR=$MYISNTALL -DCOIN_ROOT_DIR=$MYISNTALL -DBOOST_ROOT=$MYISNTALL
make
make install
cd ../..;
exit $?

