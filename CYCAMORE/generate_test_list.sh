set -x
set -e
export DYLD_LIBRARY_PATH=`pwd`/install/lib:$DYLD_LIBRARY_PATH
if [ -e install/cyclus/bin/cyclus_unit_tests ]
then
install/cyclus/bin/cyclus_unit_tests --gtest_list_tests  | python gen_test_list.py CYCLUS.
install/cyclus/bin/cyclus_unit_tests --gtest_list_tests  | python gen_test_list.py CYCLUS. > tasklist.nmi
else
if [ ! -f install/bin/cyclus_unit_tests ]; then
    echo "CYCLUS NOT PROPERLY INSTALLED"
    exit 1
fi

install/bin/cyclus_unit_tests --gtest_list_tests  | python gen_test_list.py CYCLUS.
install/bin/cyclus_unit_tests --gtest_list_tests  | python gen_test_list.py CYCLUS. > tasklist.nmi
fi

if [ -e install/cyclus/bin/cycamore_unit_tests ]
then
install/cycamore/bin/cycamore_unit_tests --gtest_list_tests  | python gen_test_list.py CYCAMORE.
install/cycamore/bin/cycamore_unit_tests --gtest_list_tests  | python gen_test_list.py CYCAMORE. >> tasklist.nmi
else
if [ ! -f install/bin/cycamore_unit_tests ]; then
    echo "CYCAMORE NOT PROPERLY INSTALLED"
    exit 1
fi

install/bin/cycamore_unit_tests --gtest_list_tests  | python gen_test_list.py CYCAMORE.
install/bin/cycamore_unit_tests --gtest_list_tests  | python gen_test_list.py CYCAMORE. >> tasklist.nmi
fi



exit $?

