set -x
set -e

mkdir install

if [ -f "ubuntu.tar.gz" ]
then
    tar -xzf ubuntu.tar.gz
fi

cd Cbc-2.8.3
find -exec touch \{\} \;
#./configure --prefix=`pwd`/../install 
cp ../lapack-3.4.2.tgz ThirdParty/Lapack/
cd ThirdParty/Lapack/
tar -xzf lapack-3.4.2.tgz
mv lapack-3.4.2 LAPACK
cd ../..

cp ../blas.tgz ThirdParty/Blas/
cd ThirdParty/Blas/
tar -xzf blas.tgz
mv BLAS/*.f .
cd ../..

./configure -v --prefix=`pwd`/../install COIN_SKIP_PROJECTS="Data/Sample, CoinUtils, Osi, Clp, Cgl, Cbc"
make
make test
make install
make clean

ls -l ../install/lib/
./configure -v --prefix=`pwd`/../install LDFLAGS="-L`pwd`/../install/lib/ -lcoinblas -lcoinlapack"
make
make test
make install
cd ..

libtool --finish `pwd`/install/lib
