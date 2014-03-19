set -x
set -e

    anaconda/bin/cyclus_unit_tests  --gtest_repeat=1



exit $?
