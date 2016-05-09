#!/bin/bash 

UNAME=`uname`
BUILD_CACHE="$RECIPE_DIR/../build/cache"
mkdir -p $BUILD_CACHE
HAMCREST="hamcrest-core-1.3.jar"
export JAVA_HOME="$(dirname $(which java))/.."

# Debug info
echo "UNAME = ${UNAME}"
echo "JAVA_HOME = ${JAVA_HOME}"

# Build won't work without this installed. Potentially a bug.
# see http://archive.linuxfromscratch.org/mail-archives/blfs-book/2014-May/042604.html
if [ ! -f $BUILD_CACHE/${HAMCREST} ]; then
  curl -o "$BUILD_CACHE/${HAMCREST}" "https://hamcrest.googlecode.com/files/${HAMCREST}"
fi
cp -v "$BUILD_CACHE/${HAMCREST}" "lib/optional/${HAMCREST}"

# Build
sh build.sh -Ddist.dir=$PREFIX dist
export ANT_OPTS="-Duser.home=$HOME"  # this line is needed for BaTLab
ant -f fetch.xml -Ddest=system
