#!/bin/sh
install/cyclus/bin/CyclusUnitTestDriver --gtest_list_tests  | python gen_test_list.py
install/cyclus/bin/CyclusUnitTestDriver --gtest_list_tests  | python gen_test_list.py > tasklist.nmi
