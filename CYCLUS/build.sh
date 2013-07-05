set -x
set -e

`pwd`/CYCLOPTS/build.sh

cd libsigc++-2.3.1
./configure --prefix=`pwd`/../install
make
make install
cd ..

cd glibmm-2.20.0
./configure --prefix=`pwd`/../install PKG_CONFIG_PATH=`pwd`/../install/lib/pkgconfig/
make
make install
cd ..

cd libxml++-2.30.0
./configure --prefix=`pwd`/../install PKG_CONFIG_PATH=`pwd`/../install/lib/pkgconfig/
make
make install
cd ..

cd boost_1_42_0/
./bootstrap.sh
./bjam install --prefix=`pwd`/../install
cd ..

cd cyclus
cmake src -DCMAKE_INSTALL_PREFIX=`pwd`/../install -DCYCLOPTS_ROOT_DIR=`pwd`/../install -DCOIN_ROOT_DIR=`pwd`/../install -DBOOST_ROOT=`pwd`/../install
make
make install
cd ..

exit $?

