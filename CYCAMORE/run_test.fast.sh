set -x
set -e
export DYLD_LIBRARY_PATH=`pwd`/install/lib:$DYLD_LIBRARY_PATH

if [ -e install/cyclus/bin/CycamoreUnitTestDriver ]
then
    install/cycamore/bin/CycamoreUnitTestDriver
else
    install/bin/CycamoreUnitTestDriver
fi
if [ -e install/cyclus/bin/cyclus_unit_tests ]
then
    install/cyclus/bin/cyclus_unit_tests
else
    install/bin/cyclus_unit_tests
fi



exit $?
