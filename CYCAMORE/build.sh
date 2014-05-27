set -x
set -e

export MYINSTALL=`pwd`/install

`pwd`/CYCLUS/build.sh
cd cycamore
mkdir build; cd build;
cmake ../ -DCMAKE_INSTALL_PREFIX=$MYINSTALL -DCYCLUS_ROOT_DIR=$MYINSTALL  -DCYCLOPTS_ROOT_DIR=$MYINSTALL -DCOIN_ROOT_DIR=$MYINSTALL -DBOOST_ROOT=$MYINSTALL -DBoost_NO_SYSTEM_PATHS=ON
make
make install
cd ../..
exit $?

