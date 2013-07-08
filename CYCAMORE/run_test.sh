set -x
set -e
if  [[ "${_NMI_TASKNAME}" == CYCAMORE* ]]
then
    install/cycamore/bin/CycamoreUnitTestDriver --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCAMORE.//g'`
else
    install/cyclus/bin/CyclusUnitTestDriver --gtest_filter=`echo ${_NMI_TASKNAME} | sed -e 's/__/\//g' | sed -e 's/CYCLUS.//g'`
fi



exit $?
