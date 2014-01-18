set -x
set -e
export DYLD_LIBRARY_PATH=`pwd`/install/lib:$DYLD_LIBRARY_PATH

if [ -e install/cyclus/bin/cycamore_unit_tests ]
then
    install/cycamore/bin/cycamore_unit_tests --gtest_repeat=1
else
    install/bin/cycamore_unit_tests --gtest_repeat=1
fi
if [ -e install/cyclus/bin/cyclus_unit_tests ]
then
    install/cyclus/bin/cyclus_unit_tests --gtest_repeat=1
else
    install/bin/cyclus_unit_tests --gtest_repeat=1
fi

# check that unit tests ran
if [ $? -ne 0 ]
then
    exit $?
fi

# run regression tests
export PYTHONPATH=$PYTHONPATH:`pwd`/install:`pwd`/install/lib/python2.7/site-packages
export LD_LIBRARY_PATH=`pwd`/install/lib/:$LD_LIBRARY_PATH
export PATH=`pwd`/install/bin/:$PATH
cd `pwd`/cycamore/tests
../../install/bin/nosetests

exit $?
