set -x
set -e

mkdir install




cd libxml++-2.30.0
./configure --prefix=`pwd`/../install
make
make install

cd ../boost_1_42_0/
./bootstrap.sh
./bjam install --prefix=`pwd`/../install


cd ../coin-Cbc
./configure --prefix=`pwd`/../install
make 
make install

cd ../cyclopts
cmake src/ -DCMAKE_INSTALL_PREFIX=`pwd`/../install -DCOIN_ROOT_DIR=`pwd`/../install
make 
make install 


cd ../cyclus
cmake src -DCMAKE_INSTALL_PREFIX=`pwd`/../install -DCYCLOPTS_ROOT_DIR=`pwd`/../install -DCOIN_ROOT_DIR=`pwd`/../install -DBOOST_ROOT=`pwd`/../install
make
make install


exit $?

