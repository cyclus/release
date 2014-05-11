set -x
set -e
export DYLD_LIBRARY_PATH=`pwd`/install/lib:$DYLD_LIBRARY_PATH

echo "Querying cyclus version"
cyclus --version



if  [[ "${_NMI_TASKNAME}" == CYCAMORE* ]]
then
    if [ -e install/cyclus/bin/cycamore_unit_tests ]
    then
    install/cycamore/bin/cycamore_unit_tests --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCAMORE.//g'`
    else
    install/bin/cycamore_unit_tests --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCAMORE.//g'`
    fi
elif [[ "${_NMI_TASKNAME}" == CYCLUS* ]]
then
    if [ -e install/cyclus/bin/cyclus_unit_tests ]
    then
    install/cyclus/bin/cyclus_unit_tests --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCLUS.//g'`
    else
    install/bin/cyclus_unit_tests --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCLUS.//g'`
    fi
else

    # run regression tests
    export PYTHONPATH=$PYTHONPATH:`pwd`/install:`pwd`/install/lib/python2.7/site-packages
    export LD_LIBRARY_PATH=`pwd`/install/lib/:$LD_LIBRARY_PATH
    export PATH=`pwd`/install/bin/:$PATH
    cd `pwd`/cyclus/tests
    ../../install/bin/nosetests
    cd ../../
    cd `pwd`/cycamore/tests
    ../../install/bin/nosetests
    cd ../../


fi

exit $?
