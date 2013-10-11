if [ -e install/cyclus/bin/cyclus_unit_tests ]
then
install/cyclus/bin/cyclus_unit_tests --gtest_list_tests  | python gen_test_list.py
install/cyclus/bin/cyclus_unit_tests --gtest_list_tests  | python gen_test_list.py > tasklist.nmi
fi
