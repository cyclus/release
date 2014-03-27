set -x
set -e
export DYLD_LIBRARY_PATH=anaconda/lib:$DYLD_LIBRARY_PATH

    anaconda/bin/cycamore_unit_tests --gtest_repeat=1
    anaconda/bin/cyclus_unit_tests --gtest_repeat=1

# check that unit tests ran
if [ $? -ne 0 ]
then
    exit $?
fi


exit $?
