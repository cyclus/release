set -x
set -e
export DYLD_LIBRARY_PATH=`pwd`/install/lib:$DYLD_LIBRARY_PATH
if [ -e install/cyclus/bin/CyclusUnitTestDriver ]
then
install/cyclus/bin/CyclusUnitTestDriver --gtest_list_tests  | python gen_test_list.py CYCLUS.
install/cyclus/bin/CyclusUnitTestDriver --gtest_list_tests  | python gen_test_list.py CYCLUS. > tasklist.nmi
else
install/bin/CyclusUnitTestDriver --gtest_list_tests  | python gen_test_list.py CYCLUS.
install/bin/CyclusUnitTestDriver --gtest_list_tests  | python gen_test_list.py CYCLUS. > tasklist.nmi
fi

if [ -e install/cyclus/bin/CycamoreUnitTestDriver ]
then
install/cycamore/bin/CycamoreUnitTestDriver --gtest_list_tests  | python gen_test_list.py CYCAMORE.
install/cycamore/bin/CycamoreUnitTestDriver --gtest_list_tests  | python gen_test_list.py CYCAMORE. >> tasklist.nmi
else
install/bin/CycamoreUnitTestDriver --gtest_list_tests  | python gen_test_list.py CYCAMORE.
install/bin/CycamoreUnitTestDriver --gtest_list_tests  | python gen_test_list.py CYCAMORE. >> tasklist.nmi
fi



exit $?

