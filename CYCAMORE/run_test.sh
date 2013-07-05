#!/bin/sh
set -x
set -e
install/cycamore/bin/CycamoreUnitTestDriver --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/_/\//g'`
exit $?
