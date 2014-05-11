set -x
set -e
export DYLD_LIBRARY_PATH=`pwd`/install/lib:$DYLD_LIBRARY_PATH
export PATH=$PATH:`pwd`/install/bin
export PYTHONPATH=$PYTHONPATH:`pwd`/install:`pwd`/install/lib/python2.7/site-packages
export LD_LIBRARY_PATH=`pwd`/install/lib/:$LD_LIBRARY_PATH

echo "Querying cyclus version"
cyclus --version

cycamore_unit_tests --gtest_repeat=1
`pwd`/install/bin/nosetests -w `pwd`/cycamore/tests

exit $?
