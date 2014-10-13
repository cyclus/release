#!/bin/bash

UNAME=$(uname)
INSTLOC="$PREFIX/share/cyclist"
if [[ $UNAME == "Linux" ]]; then
  # Linux
  RMPOST="darwin"
else
  # Mac OSX
  RMPOST="linux"
fi

# Build
ant
rm -rv deploy/dist/externalApps/*windows* deploy/dist/externalApps/*$RMPOST*

# Install
mkdir -p $INSTLOC
cp -rv deploy/dist/* $INSTLOC

mkdir -p $PREFIX/bin
echo '#!/bin/bash
# SRCDIR is a BASH hack to get the where this cyclist script is running in a 
# relocatable way.
SRCDIR="$(dirname "$(readlink -f "$0")")"
java -jar $SRCDIR/../share/cyclist/cyclist.jar
' > $PREFIX/bin/cyclist
chmod 755 $PREFIX/bin/cyclist
