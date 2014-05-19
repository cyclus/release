set -x
set -e
export DYLD_LIBRARY_PATH=`pwd`/install/lib:$DYLD_LIBRARY_PATH
export PYTHONPATH=$PYTHONPATH:`pwd`/install:`pwd`/install/lib/python2.7/site-packages
export LD_LIBRARY_PATH=`pwd`/install/lib/:$LD_LIBRARY_PATH    
export PATH=$PWD/install/bin/:$PWD/install/cyclus/bin/:$PWD/install/cycamore/bin/:$PATH

echo "Querying cyclus version"
cyclus --version

if  [[ "${_NMI_TASKNAME}" == CYCAMORE* ]]
then
    cycamore_unit_tests --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCAMORE.//g'`
elif [[ "${_NMI_TASKNAME}" == CYCLUS* ]]
then
    cyclus_unit_tests --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCLUS.//g'`
else
    # run regression tests
    nosetests -sw `pwd`/cyclus/tests
    nosetests -sw `pwd`/cycamore/tests
fi

exit $?
