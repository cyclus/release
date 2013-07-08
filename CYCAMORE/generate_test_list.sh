#!/bin/sh
install/cyclus/bin/CyclusUnitTestDriver --gtest_list_tests  | python gen_test_list.py CYCLUS.
install/cyclus/bin/CyclusUnitTestDriver --gtest_list_tests  | python gen_test_list.py CYCLUS. > tasklist.nmi
install/cycamore/bin/CycamoreUnitTestDriver --gtest_list_tests  | python gen_test_list.py CYCAMORE.
install/cycamore/bin/CycamoreUnitTestDriver --gtest_list_tests  | python gen_test_list.py CYCAMORE. >> tasklist.nmi

