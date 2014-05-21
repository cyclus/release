set -x
set -e

export INSTALL=`pwd`/install


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
./configure --prefix=$INSTALL
make
make install
cd ..

cd pkg-config-lite-0.28-1
./configure --prefix=$INSTALL
make
make install
cd ..

cd libffi-3.0.13
./configure --prefix=$INSTALL
make
make install
cd ..

cd gettext-0.18.3
./configure --prefix=$INSTALL
make
make install
cd ..

cd libsigc++-2.3.1
./configure --prefix=$INSTALL
make
make install
cd ..


cd glib-2.37.4
./configure --prefix=$INSTALL PKG_CONFIG=$INSTALL/bin/pkg-config PKG_CONFIG_PATH=$INSTALL/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALL/lib/ PATH=$PATH:$INSTALL/bin/ CPPFLAGS=-I/$INSTALL/include LDFLAGS=-L/$INSTALL/lib
make
make install
cd ..


export PATH=`pwd`/install/bin/:$PATH
cd glibmm-2.32.1
./configure --prefix=$INSTALL PKG_CONFIG=$INSTALL/bin/pkg-config PKG_CONFIG_PATH=$INSTALL/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALL/lib/ PATH=$PATH:$INSTALL/bin/ CPPFLAGS=-I/$INSTALL/include LDFLAGS=-L/$INSTALL/lib
make
make install
cd ..

cd libxml2-2.8.0
./configure --prefix=$INSTALL PKG_CONFIG=$INSTALL/bin/pkg-config PKG_CONFIG_PATH=$INSTALL/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALL/lib/ PATH=$PATH:$INSTALL/bin/ CPPFLAGS=-I/$INSTALL/include LDFLAGS=-L/$INSTALL/lib

make
make install
cd ..

cd libxml++-2.36.0
./configure --prefix=$INSTALL PKG_CONFIG=$INSTALL/bin/pkg-config PKG_CONFIG_PATH=$INSTALL/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INSTALL/lib/ PATH=$PATH:$INSTALL/bin/ CPPFLAGS=-I/$INSTALL/include LDFLAGS=-L/$INSTALL/lib
make
make install
cd ..

cd boost_1_50_0/
./bootstrap.sh
./bjam install --prefix=$INSTALL
cd ..

ls install/lib/


cd hdf5-1.8.4
./configure --prefix=$INSTALL
make
make install
cd ..

fi

tar -czf results.tar.gz install

cd cyclus
mkdir `pwd`/build; cd build;
cmake .. -DCMAKE_INSTALL_PREFIX=$INSTALL -DCYCLOPTS_ROOT_DIR=$INSTALL -DCOIN_ROOT_DIR=$INSTALL -DBOOST_ROOT=$INSTALL
make
make install
cd ../..

mkdir -p `pwd`/install/lib/python2.7/site-packages
export PYTHONPATH=$PYTHONPATH:`pwd`/install:`pwd`/install/lib/python2.7/site-packages
cd nose
python setup.py install --prefix=$INSTALL
cd ../numpy
python setup.py install --prefix=$INSTALL
cd ../cython
python setup.py install --prefix=$INSTALL
cd ../numexpr
python setup.py install --prefix=$INSTALL
cd ../PyTables
python setup.py install --prefix=$INSTALL --hdf5=$INSTALL
cd ..

exit $?

