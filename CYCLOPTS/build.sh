set -x
set -e

mkdir install

cd coin-Cbc
ls -l
find -exec touch \{\} \;
./configure --prefix=`pwd`/../install
make
make install
cd ..

cd cyclopts
cmake src/ -DCMAKE_INSTALL_PREFIX=`pwd`/../install -DCOIN_ROOT_DIR=`pwd`/../install
make 
make install 
cd ..
