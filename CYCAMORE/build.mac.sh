set -x
set -e

export MYINSTALL=`pwd`/install

export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:`pwd`/install/lib/

`pwd`/CYCLUS/build.mac.sh
cd cycamore
mkdir build; cd build;
cmake .. -DCMAKE_INSTALL_PREFIX=$MYINSTALL -DCYCLUS_ROOT_DIR=$MYINSTALL  -DCYCLOPTS_ROOT_DIR=$MYINSTALL -DCOIN_ROOT_DIR=$MYINSTALL -DBOOST_ROOT=$MYINSTALL
make
make install
cd ../..;
exit $?

