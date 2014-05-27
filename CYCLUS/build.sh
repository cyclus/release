set -x
set -e

DIR=`pwd`

export MYISNTALL=`pwd`/install

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
#./configure --prefix=$MYISNTALL 
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

./configure -v --prefix=$MYISNTALL COIN_SKIP_PROJECTS="Data/Sample, CoinUtils, Osi, Clp, Cgl, Cbc"
make
make test
make install
make clean

ls -l ../install/lib/
./configure -v --prefix=$MYISNTALL LDFLAGS="-L$MYISNTALL/lib/ -lcoinblas -lcoinlapack"
make
make test
make install
cd ..

libtool --finish `pwd`/install/lib



cd libsigc++-2.3.1

make
make install
cd ..

cd glibmm-2.32.1
./configure --prefix=$MYISNTALL PKG_CONFIG_PATH=$MYISNTALL/lib/pkgconfig/
make
make install
cd ..

cd libxml++-2.36.0
./configure --prefix=$MYISNTALL PKG_CONFIG_PATH=$MYISNTALL/lib/pkgconfig/
make
make install
cd ..

cd boost_1_50_0/
./bootstrap.sh
./bjam install --prefix=$MYISNTALL
cd ..

cd hdf5-1.8.4
./configure --prefix=$MYISNTALL
make
make install
cd ..
DIR=`pwd`

fi

export LD_LIBRARY_PATH=`pwd`/install/lib/:$LD_LIBRARY_PATH
export CMAKE_LIBRARY_PATH=`pwd`/install/lib/:$CMAKE_LIBRARY_PATH
export LD_RUN_PATH=`pwd`/lapack-3.2.1/:$LD_RUN_PATH
echo $LD_LIBRARY_PATH


tar -czf results.tar.gz install

cd cyclus

find -exec touch \{\} \;
#cmake src  -DCMAKE_SHARED_LINKER_FLAGS="-L`pwd`/../lapack-3.2.1/" -DCMAKE_MYISNTALL_PREFIX=$MYISNTALL -DCYCLOPTS_ROOT_DIR=$MYISNTALL -DCOIN_ROOT_DIR=$MYISNTALL -DBOOST_ROOT=$MYISNTALL -DLAPACK_LIBRARIES=`pwd`/../lapack-3.2.1/liblapack.a -DBLAS_LIBRARIES=`pwd`/../lapack-3.2.1/libblas.a -DLAPACK_DIR=`pwd`/../lapack-3.2.1/

mkdir `pwd`/build; cd build;
cmake ..  -DCMAKE_EXE_LINKER_FLAGS="-L/$MYISNTALL/lib -lcoinblas -lcoinlapack -L/$MYISNTALL/lib/libboost_filesystem.so.1.50.0" -DCMAKE_INSTALL_PREFIX=$MYISNTALL -DCOIN_ROOT_DIR=$MYISNTALL -DBOOST_ROOT=$MYISNTALL -DBoost_NO_SYSTEM_PATHS=ON
make
make install
cd ../..

mkdir -p `pwd`/install/lib/python2.7/site-packages
export PYTHONPATH=$PYTHONPATH:`pwd`/install:`pwd`/install/lib/python2.7/site-packages
cd nose
python setup.py install --prefix=$MYISNTALL
cd ../numpy
python setup.py install --prefix=$MYISNTALL
cd ../cython
python setup.py install --prefix=$MYISNTALL
cd ../numexpr
python setup.py install --prefix=$MYISNTALL
cd ../PyTables
python setup.py install --prefix=$MYISNTALL --hdf5=$MYISNTALL
cd ..
exit $?

