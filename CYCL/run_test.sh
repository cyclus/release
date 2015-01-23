set -x
set -e
    # check that unit tests ran
PATH=`pwd`/anaconda/bin:$PATH
anaconda/bin/cyclus --version
    if [[ "${_NMI_TASKNAME}" == CYCLUS* ]]
    then
        anaconda/bin/cyclus_unit_tests --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCLUS.//g'`
    elif [[  "${_NMI_TASKNAME}" == R*  ]]
    then
    
        # run regression tests
        export PYTHONPATH=$PYTHONPATH:anaconda:anaconda/lib/python2.7/site-packages
        export LD_LIBRARY_PATH=anaconda/lib/:$LD_LIBRARY_PATH
        export PATH=anaconda/bin/:$PATH
        anaconda/bin/nosetests -vsw cycltest
    else
    anaconda/bin/cyclus_unit_tests --gtest_repeat=1
    anaconda/bin/nosetests -vsw cycltest
    # check that unit tests ran
    if [ $? -ne 0 ]
    then
        exit $?
    fi
fi

exit $?


