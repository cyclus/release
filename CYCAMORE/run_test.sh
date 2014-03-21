set -x
set -e
export DYLD_LIBRARY_PATH=anaconda/lib:$DYLD_LIBRARY_PATH



if  [[ "${_NMI_TASKNAME}" == CYCAMORE* ]]
then
    anaconda/bin/cycamore_unit_tests --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCAMORE.//g'`
elif [[ "${_NMI_TASKNAME}" == CYCLUS* ]]
then
    anaconda/bin/cyclus_unit_tests --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCLUS.//g'`
else

    # run regression tests
    export PYTHONPATH=$PYTHONPATH:anaconda:anaconda/lib/python2.7/site-packages
    export LD_LIBRARY_PATH=anaconda/lib/:$LD_LIBRARY_PATH
    export PATH=anaconda/bin/:$PATH
    cd `pwd`/cycamore/tests
    ../../anaconda/bin/nosetests


fi

exit $?
