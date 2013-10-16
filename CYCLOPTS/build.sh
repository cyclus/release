set -x
set -e

mkdir install
#tar -xzf blas.tgz
#tar -xzf lapack-3.4.2.tgz
#cd BLAS
#make
#mv blas_LINUX.a ../lapack-3.4.2
#ls -l
#make install
#cd ..
#cd ..

#cd lapack-3.4.2
#cmake -DCMAKE_INSTALL_PREFIX=`pwd`/../install -DBLAS_LIBRARIES=`pwd`/../BLAS/blas_LINUX.a
#cp make.inc.example make.inc
#make
#mv lapack_LINUX.a libcoinlapack.a
#mv blas_LINUX.a libcoinblas.a
##make install
#ls -l 
#ls -l BLAS
#mv *.a ../install/lib/
##cd ..


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
