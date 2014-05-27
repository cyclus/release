set -x
set -e

export MYISNTALL=`pwd`/install


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
./configure --prefix=$MYISNTALL
make
make install
cd ..

cd pkg-config-lite-0.28-1
./configure --prefix=$MYISNTALL
make
make install
cd ..

cd libffi-3.0.13
./configure --prefix=$MYISNTALL
make
make install
cd ..

cd gettext-0.18.3
./configure --prefix=$MYISNTALL
make
make install
cd ..

cd libsigc++-2.3.1
./configure --prefix=$MYISNTALL
make
make install
cd ..


cd glib-2.37.4
./configure --prefix=$MYISNTALL PKG_CONFIG=$MYISNTALL/bin/pkg-config PKG_CONFIG_PATH=$MYISNTALL/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MYISNTALL/lib/ PATH=$PATH:$MYISNTALL/bin/ CPPFLAGS=-I/$MYISNTALL/include LDFLAGS=-L/$MYISNTALL/lib
make
make install
cd ..


export PATH=`pwd`/install/bin/:$PATH
cd glibmm-2.32.1
./configure --prefix=$MYISNTALL PKG_CONFIG=$MYISNTALL/bin/pkg-config PKG_CONFIG_PATH=$MYISNTALL/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MYISNTALL/lib/ PATH=$PATH:$MYISNTALL/bin/ CPPFLAGS=-I/$MYISNTALL/include LDFLAGS=-L/$MYISNTALL/lib
make
make install
cd ..

cd libxml2-2.8.0
./configure --prefix=$MYISNTALL PKG_CONFIG=$MYISNTALL/bin/pkg-config PKG_CONFIG_PATH=$MYISNTALL/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MYISNTALL/lib/ PATH=$PATH:$MYISNTALL/bin/ CPPFLAGS=-I/$MYISNTALL/include LDFLAGS=-L/$MYISNTALL/lib

make
make install
cd ..

cd libxml++-2.36.0
./configure --prefix=$MYISNTALL PKG_CONFIG=$MYISNTALL/bin/pkg-config PKG_CONFIG_PATH=$MYISNTALL/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MYISNTALL/lib/ PATH=$PATH:$MYISNTALL/bin/ CPPFLAGS=-I/$MYISNTALL/include LDFLAGS=-L/$MYISNTALL/lib
make
make install
cd ..

cd boost_1_50_0/
./bootstrap.sh
./bjam install --prefix=$MYISNTALL
cd ..

ls install/lib/


cd hdf5-1.8.4
./configure --prefix=$MYISNTALL
make
make install
cd ..

fi

tar -czf results.tar.gz install

cd cyclus
mkdir `pwd`/build; cd build;
cmake .. -DCMAKE_INSTALL_PREFIX=$MYISNTALL -DCYCLOPTS_ROOT_DIR=$MYISNTALL -DCOIN_ROOT_DIR=$MYISNTALL -DBOOST_ROOT=$MYISNTALL
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

