set -x
set -e

DIR=`pwd`



if [ -f "ubuntu.fast.tar.gz" ]
then
    tar -xzf ubuntu.fast.tar.gz
else

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



cd libsigc++-2.3.1
./configure --prefix=`pwd`/../install
make
make install
cd ..

cd glibmm-2.30.0
./configure --prefix=`pwd`/../install PKG_CONFIG_PATH=`pwd`/../install/lib/pkgconfig/
make
make install
cd ..

cd libxml++-2.30.0
./configure --prefix=`pwd`/../install PKG_CONFIG_PATH=`pwd`/../install/lib/pkgconfig/
make
make install
cd ..

cd boost_1_50_0/
./bootstrap.sh
./bjam install --prefix=`pwd`/../install
cd ..

cd hdf5-1.8.4
./configure --prefix=`pwd`/../install
make
make install
cd ..
DIR=`pwd`

fi

export LD_LIBRARY_PATH=`pwd`/install/lib/:$LD_LIBRARY_PATH
export CMAKE_LIBRARY_PATH=`pwd`/install/lib/:$CMAKE_LIBRARY_PATH
export LD_RUN_PATH=`pwd`/lapack-3.2.1/:$LD_RUN_PATH
echo $LD_LIBRARY_PATH
cd cyclus

find -exec touch \{\} \;
#cmake src  -DCMAKE_SHARED_LINKER_FLAGS="-L`pwd`/../lapack-3.2.1/" -DCMAKE_INSTALL_PREFIX=`pwd`/../install -DCYCLOPTS_ROOT_DIR=`pwd`/../install -DCOIN_ROOT_DIR=`pwd`/../install -DBOOST_ROOT=`pwd`/../install -DLAPACK_LIBRARIES=`pwd`/../lapack-3.2.1/liblapack.a -DBLAS_LIBRARIES=`pwd`/../lapack-3.2.1/libblas.a -DLAPACK_DIR=`pwd`/../lapack-3.2.1/

cmake `pwd`  -DCMAKE_EXE_LINKER_FLAGS="-L/`pwd`/../install/lib -lcoinblas -lcoinlapack " -DCMAKE_INSTALL_PREFIX=`pwd`/../install -DCYCLOPTS_ROOT_DIR=`pwd`/../install -DCOIN_ROOT_DIR=`pwd`/../install -DBOOST_ROOT=`pwd`/../install
make
make install
cd ..
#rm results.tar.gz
exit $?

