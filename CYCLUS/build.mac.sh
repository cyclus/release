set -x
set -e


if [ -f "mac.fast.tar.gz" ]
then
    tar -xzf mac.fast.tar.gz

else


mkdir install

if [ -f "mac.tar.gz" ]
then
    tar -xzf mac.tar.gz
fi

cd Cbc-2.8.3
ls -l
./configure --prefix=`pwd`/../install
make
make install
cd ..

cd pkg-config-lite-0.28-1
./configure --prefix=`pwd`/../install
make
make install
cd ..

cd libffi-3.0.13
./configure --prefix=`pwd`/../install
make
make install
cd ..

cd gettext-0.18.3
./configure --prefix=`pwd`/../install
make
make install
cd ..

cd libsigc++-2.3.1
./configure --prefix=`pwd`/../install
make
make install
cd ..


cd glib-2.37.4
./configure --prefix=`pwd`/../install PKG_CONFIG=`pwd`/../install/bin/pkg-config PKG_CONFIG_PATH=`pwd`/../install/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/../install/lib/ PATH=$PATH:`pwd`/../install/bin/ CPPFLAGS=-I/`pwd`/../install/include LDFLAGS=-L/`pwd`/../install/lib
make
make install
cd ..


export PATH=`pwd`/install/bin/:$PATH
cd glibmm-2.30.0
./configure --prefix=`pwd`/../install PKG_CONFIG=`pwd`/../install/bin/pkg-config PKG_CONFIG_PATH=`pwd`/../install/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/../install/lib/ PATH=$PATH:`pwd`/../install/bin/ CPPFLAGS=-I/`pwd`/../install/include LDFLAGS=-L/`pwd`/../install/lib
make
make install
cd ..

cd libxml2-2.8.0
./configure --prefix=`pwd`/../install PKG_CONFIG=`pwd`/../install/bin/pkg-config PKG_CONFIG_PATH=`pwd`/../install/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/../install/lib/ PATH=$PATH:`pwd`/../install/bin/ CPPFLAGS=-I/`pwd`/../install/include LDFLAGS=-L/`pwd`/../install/lib

make
make install
cd ..

cd libxml++-2.30.0
./configure --prefix=`pwd`/../install PKG_CONFIG=`pwd`/../install/bin/pkg-config PKG_CONFIG_PATH=`pwd`/../install/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`pwd`/../install/lib/ PATH=$PATH:`pwd`/../install/bin/ CPPFLAGS=-I/`pwd`/../install/include LDFLAGS=-L/`pwd`/../install/lib
make
make install
cd ..

cd boost_1_50_0/
./bootstrap.sh
./bjam install --prefix=`pwd`/../install
cd ..

ls install/lib/


cd hdf5-1.8.4
./configure --prefix=`pwd`/../install
make
make install
cd ..

fi

cd cyclus
cmake `pwd` -DCMAKE_INSTALL_PREFIX=`pwd`/../install -DCYCLOPTS_ROOT_DIR=`pwd`/../install -DCOIN_ROOT_DIR=`pwd`/../install -DBOOST_ROOT=`pwd`/../install
make
make install
cd ..

exit $?

