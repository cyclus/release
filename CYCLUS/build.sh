set -x
set -e

DIR=`pwd`

export MYINSTALL=`pwd`/install

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
#./configure --prefix=$MYINSTALL 
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

./configure -v --prefix=$MYINSTALL COIN_SKIP_PROJECTS="Data/Sample, CoinUtils, Osi, Clp, Cgl, Cbc"
make
make test
make install
make clean

ls -l ../install/lib/
./configure -v --prefix=$MYINSTALL LDFLAGS="-L$MYINSTALL/lib/ -lcoinblas -lcoinlapack"
make
make test
make install
cd ..

libtool --finish `pwd`/install/lib



cd libsigc++-2.3.1
./configure --prefix=$MYINSTALL
make
make install
cd ..

cd glibmm-2.32.1
./configure --prefix=$MYINSTALL PKG_CONFIG_PATH=$MYINSTALL/lib/pkgconfig/
make
make install
cd ..

cd libxml++-2.36.0
./configure --prefix=$MYINSTALL PKG_CONFIG_PATH=$MYINSTALL/lib/pkgconfig/
make
make install
cd ..

cd boost_1_50_0/
./bootstrap.sh
./bjam install --prefix=$MYINSTALL
cd ..

cd hdf5-1.8.4
./configure --prefix=$MYINSTALL
make
make install
cd ..
DIR=`pwd`

fi

export LD_LIBRARY_PATH=`pwd`/install/lib/:$LD_LIBRARY_PATH
export CMAKE_LIBRARY_PATH=`pwd`/install/lib/:$CMAKE_LIBRARY_PATH
export LD_RUN_PATH=`pwd`/lapack-3.2.1/:$LD_RUN_PATH
echo $LD_LIBRARY_PATH

cd doxygen
./configure --prefix $MYINSTALL
make
make install
cd ..

cd cyclus

find -exec touch \{\} \;
#cmake src  -DCMAKE_SHARED_LINKER_FLAGS="-L`pwd`/../lapack-3.2.1/" -DCMAKE_MYINSTALL_PREFIX=$MYINSTALL -DCYCLOPTS_ROOT_DIR=$MYINSTALL -DCOIN_ROOT_DIR=$MYINSTALL -DBOOST_ROOT=$MYINSTALL -DLAPACK_LIBRARIES=`pwd`/../lapack-3.2.1/liblapack.a -DBLAS_LIBRARIES=`pwd`/../lapack-3.2.1/libblas.a -DLAPACK_DIR=`pwd`/../lapack-3.2.1/

mkdir `pwd`/build; cd build;
cmake ..  -DCMAKE_EXE_LINKER_FLAGS="-L/$MYINSTALL/lib -lcoinblas -lcoinlapack -L/$MYINSTALL/lib/libboost_filesystem.so.1.50.0" -DCMAKE_INSTALL_PREFIX=$MYINSTALL -DCOIN_ROOT_DIR=$MYINSTALL -DBOOST_ROOT=$MYINSTALL -DBoost_NO_SYSTEM_PATHS=ON
make
make install
cd ../..

mkdir -p `pwd`/install/lib/python2.7/site-packages
export PYTHONPATH=$PYTHONPATH:`pwd`/install:`pwd`/install/lib/python2.7/site-packages
cd nose
python setup.py install --prefix=$MYINSTALL
cd ../numpy
python setup.py install --prefix=$MYINSTALL
cd ../cython
python setup.py install --prefix=$MYINSTALL
cd ../numexpr
python setup.py install --prefix=$MYINSTALL
cd ../PyTables
python setup.py install --prefix=$MYINSTALL --hdf5=$MYINSTALL
cd ..
exit $?

