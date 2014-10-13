#!/bin/bash 

BUILD_CACHE="$RECIPE_DIR/../build/cache"
mkdir -p $BUILD_CACHE
UNAME=`uname`
if [[ $UNAME == "Linux" ]]; then
  # Linux
  URL="http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jre-8u20-linux-x64.tar.gz"
  NSTRIP=1
  LINKLOC="$PREFIX/lib/*/jli"
else
  # MacOSX
  URL="http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jre-8u20-macosx-x64.tar.gz"
  NSTRIP=3
  LINKLOC="$PREFIX/lib/jli"
fi

# this must exist because ln does not have the -r option in Mac. Apple, unix - but not!
relpath(){ python -c "import os.path; print(os.path.relpath('$1','${2:-$PWD}'))" ; }

# Download
if [ ! -f $BUILD_CACHE/jre.tar.gz ]; then
  curl -L -C - -b "oraclelicense=accept-securebackup-cookie" -o $BUILD_CACHE/jre.tar.gz $URL
fi
cp -v $BUILD_CACHE/jre.tar.gz jre.tar.gz

# Install
tar xvf jre.tar.gz --strip-components=$NSTRIP -C $PREFIX
ln -s $LINKLOC/*jli.* $(relpath $PREFIX/lib $LINKLOC/*jli.*)

# Some clean up
rm -rf $PREFIX/release $PREFIX/README $PREFIX/Welcome.html $PREFIX/*jli.*
chmod og+w $PREFIX/COPYRIGHT $PREFIX/LICENSE $PREFIX/THIRDPARTYLICENSEREADME.txt
mv $PREFIX/COPYRIGHT $PREFIX/COPYRIGHT-JRE
mv $PREFIX/LICENSE $PREFIX/LICENSE-JRE
mv $PREFIX/THIRDPARTYLICENSEREADME.txt $PREFIX/THIRDPARTYLICENSEREADME-JRE.txt


