#!/bin/bash 

UNAME=`uname`
if [[ $UNAME == "Linux" ]]; then
  URL="http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jre-8u20-linux-x64.tar.gz"
else
  URL="http://download.oracle.com/otn-pub/java/jdk/8u20-b26/jre-8u20-macosx-x64.tar.gz"
fi

# Download
curl -L -C - -b "oraclelicense=accept-securebackup-cookie" -o jre.tar.gz $URL

# Install
tar xvf jre.tar.gz --strip-components=1 -C $PREFIX
ln -sr $PREFIX/lib/*/jli/*jli.* $PREFIX/lib

# Some clean up
rm -rf $PREFIX/release $PREFIX/README $PREFIX/Welcome.html
chmod og+w $PREFIX/COPYRIGHT $PREFIX/LICENSE $PREFIX/THIRDPARTYLICENSEREADME.txt
mv $PREFIX/COPYRIGHT $PREFIX/COPYRIGHT-JRE
mv $PREFIX/LICENSE $PREFIX/LICENSE-JRE
mv $PREFIX/THIRDPARTYLICENSEREADME.txt $PREFIX/THIRDPARTYLICENSEREADME-JRE.txt


