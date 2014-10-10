#!/bin/bash 

UNAME=`uname`
HAMCREST="hamcrest-core-1.3.jar"
if [[ $UNAME == "Linux" ]]; then
  # Linux
  export JAVA_HOME="$(dirname $(which java))/.."
else
  # MacOSX
  :
fi

# Debug info
echo "UNAME = ${UNAME}"
echo "JAVA_HOME = ${JAVA_HOME}"

# Build won't work without this installed. Potentially a bug.
# see http://archive.linuxfromscratch.org/mail-archives/blfs-book/2014-May/042604.html
curl -o "lib/optional/${HAMCREST}" "https://hamcrest.googlecode.com/files/${HAMCREST}"

# Build
sh build.sh -Ddist.dir=$PREFIX dist
ant -f fetch.xml -Ddest=system