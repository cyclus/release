set -x
set -e
export DYLD_LIBRARY_PATH=`pwd`/install/lib:$DYLD_LIBRARY_PATH
export PYTHONPATH=$PYTHONPATH:`pwd`/install:`pwd`/install/lib/python2.7/site-packages
export LD_LIBRARY_PATH=`pwd`/install/lib/:$LD_LIBRARY_PATH    
export PATH=$PWD/install/bin/:$PWD/install/cyclus/bin/:$PATH

echo "Querying version info"
cmake --version
cyclus --version

cyclus_unit_tests --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCLUS.//g'`

nosetests -sw `pwd`/cyclus/tests

exit $?
