#!/bin/sh
set -x
set -e
    if [ -e install/cyclus/bin/CyclusUnitTestDriver ]
    then
    install/cyclus/bin/CyclusUnitTestDriver --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCLUS.//g'`
    else
    install/bin/CyclusUnitTestDriver --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCLUS.//g'`
    fi

exit $?
