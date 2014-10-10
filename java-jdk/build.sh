#!/bin/bash 

UNAME=`uname`
if [[ $UNAME == "Linux" ]]; then
  # Linux
  URL="http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-linux-x64.tar.gz"
  NSTRIP=1
  LINKLOC="$PREFIX/lib/*/jli"
else
  # MacOSX
  URL="http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jdk-8u20-macosx-x64.dmg"
  NSTRIP=3
  LINKLOC="$PREFIX/lib/jli"
fi

# Download
curl -L -C - -b "oraclelicense=accept-securebackup-cookie" -o jdk.tar.gz $URL

# Install
tar xvf jdk.tar.gz --strip-components=$NSTRIP -C $PREFIX
ln -sr $LINKLOC/*jli.* $PREFIX/lib

# Some clean up
rm -rf $PREFIX/release $PREFIX/README $PREFIX/Welcome.html $PREFIX/*jli.*
chmod og+w $PREFIX/COPYRIGHT $PREFIX/LICENSE $PREFIX/THIRDPARTYLICENSEREADME.txt
mv $PREFIX/COPYRIGHT $PREFIX/COPYRIGHT-JDK
mv $PREFIX/LICENSE $PREFIX/LICENSE-JDK
mv $PREFIX/THIRDPARTYLICENSEREADME.txt $PREFIX/THIRDPARTYLICENSEREADME-JDK.txt


