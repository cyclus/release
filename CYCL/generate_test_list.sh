set -x
set -e
export DYLD_LIBRARY_PATH=`pwd`/anaconda/lib:`pwd`/anaconda/lib/cyclus:$DYLD_LIBRARY_PATH
if [ -e install/cyclus/bin/cyclus_unit_tests ]
then
anaconda/bin/cyclus_unit_tests --gtest_list_tests  | python gen_test_list.py CYCLUS.
anaconda/bin/cyclus_unit_tests --gtest_list_tests  | python gen_test_list.py CYCLUS. > tasklist.nmi
else
if [ ! -f anaconda/bin/cyclus_unit_tests ]; then
    echo "CYCLUS NOT PROPERLY INSTALLED"
    exit 1
fi

anaconda/bin/cyclus_unit_tests --gtest_list_tests  | python gen_test_list.py CYCLUS.
anaconda/bin/cyclus_unit_tests --gtest_list_tests  | python gen_test_list.py CYCLUS. > tasklist.nmi
fi




exit $?

