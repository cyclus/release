#!/bin/bash

UNAME=$(uname)
INSTLOC="$PREFIX/share/cyclist"
export JAVA_HOME="$(dirname $(which java))/.."
if [[ $UNAME == "Linux" ]]; then
  # Linux
  RMPOST="darwin"
  SCRIPT='#!/bin/bash
          # SRCDIR is a BASH hack to get the where this cyclist script is running in a 
          # relocatable way.
          SRCDIR="$(dirname "$(readlink -f "$0")")"
          PREFIX_DIR=$(dirname $SRCDIR)
          export LD_LIBRARY_PATH="${PREFIX_DIR}/lib:${PREFIX_DIR}/lib/amd64:${LD_LIBRARY_PATH}"
          java -jar ${PREFIX_DIR}/share/cyclist/cyclist.jar
          '
else
  # Mac OSX
  RMPOST="linux"
  SCRIPT='#!/bin/bash
          # SRCDIR is a BASH hack to get the where this cyclist script is running in a 
          # relocatable way.
          SRCDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
          PREFIX_DIR=$(dirname $SRCDIR)
          export LD_LIBRARY_PATH="${PREFIX_DIR}/lib:${PREFIX_DIR}/lib/amd64:${LD_LIBRARY_PATH}"
          export DYLD_FALLBACK_LIBRARY_PATH="${PREFIX_DIR}/lib:${PREFIX_DIR}/lib/amd64:${DYLD_FALLBACK_LIBRARY_PATH}"
          java -jar ${PREFIX_DIR}/share/cyclist/cyclist.jar
          '
fi

# Build
ant
rm -rv deploy/dist/externalApps/*windows* deploy/dist/externalApps/*$RMPOST*

# Install
mkdir -p $INSTLOC
cp -rv deploy/dist/* $INSTLOC

mkdir -p $PREFIX/bin
echo "$SCRIPT" | sed 's/^ *//g' > $PREFIX/bin/cyclist
chmod 755 $PREFIX/bin/cyclist
