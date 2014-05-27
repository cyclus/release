set -x
set -e
export DYLD_LIBRARY_PATH=`pwd`/anaconda/lib:`pwd`/anaconda/lib/cyclus:$DYLD_LIBRARY_PATH
export LD_LIBRARY_PATH=`pwd`/anaconda/lib:`pwd`/anaconda/lib/cyclus:$LD_LIBRARY_PATH

anaconda/bin/cyclus_unit_tests --gtest_list_tests  | python gen_test_list.py CYCLUS.
anaconda/bin/cyclus_unit_tests --gtest_list_tests  | python gen_test_list.py CYCLUS. > tasklist.nmi

anaconda/bin/cycamore_unit_tests --gtest_list_tests  | python gen_test_list.py CYCAMORE.
anaconda/bin/cycamore_unit_tests --gtest_list_tests  | python gen_test_list.py CYCAMORE. >> tasklist.nmi


echo "Regression_Test" >> tasklist.nmi

cat tasklist.nmi

exit $?

