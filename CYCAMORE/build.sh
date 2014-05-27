set -x
set -e

export MYISNTALL=`pwd`/install

`pwd`/CYCLUS/build.sh
cd cycamore
mkdir build; cd build;
cmake ../ -DCMAKE_INSTALL_PREFIX=$MYISNTALL -DCYCLUS_ROOT_DIR=$MYISNTALL  -DCYCLOPTS_ROOT_DIR=$MYISNTALL -DCOIN_ROOT_DIR=$MYISNTALL -DBOOST_ROOT=$MYISNTALL -DBoost_NO_SYSTEM_PATHS=ON
make
make install
cd ../..
exit $?

