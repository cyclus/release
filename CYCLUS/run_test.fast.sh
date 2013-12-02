set -x
set -e
export DYLD_LIBRARY_PATH=`pwd`/install/lib:$DYLD_LIBRARY_PATH

if [ -e install/cyclus/bin/cyclus_unit_tests ]
then
    install/cyclus/bin/cyclus_unit_tests --gtest_repeat=1
else
    install/bin/cyclus_unit_tests --gtest_repeat=1
fi



exit $?
