set -x
set -e
CYCLUS_MODULE_PATH=anaconda/
    anaconda/bin/cyclus_unit_tests  --gtest_catch_exceptions=0  --gtest_repeat=1



exit $?
