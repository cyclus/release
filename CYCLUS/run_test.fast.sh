set -x
set -e
export DYLD_LIBRARY_PATH=`pwd`/install/lib:$DYLD_LIBRARY_PATH
export PATH=$PATH:`pwd`/install/bin

cyclus_unit_tests --gtest_repeat=1
nosetests -w `pwd`/cyclus/tests


exit $?
