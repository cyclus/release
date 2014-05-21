set -x
set -e

export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:`pwd`/install/lib/

`pwd`/CYCLUS/build.mac.sh
cd cycamore
mkdir build; cd build;
cmake .. -DCMAKE_INSTALL_PREFIX=`pwd`/../install -DCYCLUS_ROOT_DIR=`pwd`/../install  -DCYCLOPTS_ROOT_DIR=`pwd`/../install -DCOIN_ROOT_DIR=`pwd`/../install -DBOOST_ROOT=`pwd`/../install
make
make install
cd ../..;
exit $?

