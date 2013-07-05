#!/bin/sh
set -x
set -e
install/cyclus/bin/CyclusUnitTestDriver --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g'`
exit $?
