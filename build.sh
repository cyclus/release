set -x
set -e
mkdir install



cd ../glibmm-2.4.0
./configure --prefix=`pwd`/../install
make
make install


cd ../libxml++-2.30.0
./configure --prefix=`pwd`/../install
make
make install

cd coin-Cbc
./configure --prefix=`pwd`/../install
make 
make install


cd ../cyclopts
cmake src/ -DCMAKE_INSTALL_PREFIX=`pwd`/../install -DCOIN_ROOT_DIR=`pwd`/../install
make 
make install 



cd ../cyclus
cmake src -DCMAKE_INSTALL_PREFIX=`pwd`/../install -DCYCLOPTS_ROOT_DIR=`pwd`/../install -DCOIN_ROOT_DIR=`pwd`../install
make
make install


exit $?

