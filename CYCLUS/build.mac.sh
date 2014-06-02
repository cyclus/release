set -x
set -e

export MYINSTALL=`pwd`/install


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
./configure --prefix=$MYINSTALL
make
make install
cd ..

cd pkg-config-lite-0.28-1
./configure --prefix=$MYINSTALL
make
make install
cd ..

cd libffi-3.0.13
./configure --prefix=$MYINSTALL
make
make install
cd ..

cd gettext-0.18.3
./configure --prefix=$MYINSTALL
make
make install
cd ..

cd libsigc++-2.3.1
./configure --prefix=$MYINSTALL
make
make install
cd ..


cd glib-2.37.4
./configure --prefix=$MYINSTALL PKG_CONFIG=$MYINSTALL/bin/pkg-config PKG_CONFIG_PATH=$MYINSTALL/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MYINSTALL/lib/ PATH=$PATH:$MYINSTALL/bin/ CPPFLAGS=-I/$MYINSTALL/include LDFLAGS=-L/$MYINSTALL/lib
make
make install
cd ..


export PATH=`pwd`/install/bin/:$PATH
cd glibmm-2.32.1
./configure --prefix=$MYINSTALL PKG_CONFIG=$MYINSTALL/bin/pkg-config PKG_CONFIG_PATH=$MYINSTALL/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MYINSTALL/lib/ PATH=$PATH:$MYINSTALL/bin/ CPPFLAGS=-I/$MYINSTALL/include LDFLAGS=-L/$MYINSTALL/lib
make
make install
cd ..

cd libxml2-2.8.0
./configure --prefix=$MYINSTALL PKG_CONFIG=$MYINSTALL/bin/pkg-config PKG_CONFIG_PATH=$MYINSTALL/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MYINSTALL/lib/ PATH=$PATH:$MYINSTALL/bin/ CPPFLAGS=-I/$MYINSTALL/include LDFLAGS=-L/$MYINSTALL/lib

make
make install
cd ..

cd libxml++-2.36.0
./configure --prefix=$MYINSTALL PKG_CONFIG=$MYINSTALL/bin/pkg-config PKG_CONFIG_PATH=$MYINSTALL/lib/pkgconfig LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MYINSTALL/lib/ PATH=$PATH:$MYINSTALL/bin/ CPPFLAGS=-I/$MYINSTALL/include LDFLAGS=-L/$MYINSTALL/lib
make
make install
cd ..

cd boost_1_50_0/
./bootstrap.sh
./bjam install --prefix=$MYINSTALL
cd ..

ls install/lib/


cd hdf5-1.8.4
./configure --prefix=$MYINSTALL
make
make install
cd ..

fi


cd cyclus
mkdir `pwd`/build; cd build;
cmake .. -DCMAKE_INSTALL_PREFIX=$MYINSTALL -DCYCLOPTS_ROOT_DIR=$MYINSTALL -DCOIN_ROOT_DIR=$MYINSTALL -DBOOST_ROOT=$MYINSTALL
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

