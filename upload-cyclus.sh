#!/bin/bash 
# This script takes one argument, which is the BaTLab job Run ID or Global ID

# Setup binstar
which binstar > /dev/null 2>&1
if [ $? -ne 0 ]; then
  export PATH="${HOME}/miniconda/bin:${PATH}"
fi

set -e
#set -x  # Uncomment for debugging

ID="$1"
if [ "$ID" == "" ]; then 
  echo "Please pass in a run id!"
  echo "  $ ./upload-cyclus.sh 424242"
  exit 1
fi
# split rundirs on colons, see 
# http://stackoverflow.com/questions/25638795/bash-while-loop-with-read-and-ifs
IFS=':' read -ra RUNDIRS <<< $(nmi_rundir $ID)
RUNDIRS=($RUNDIRS)
RUNDIR="${RUNDIRS[2]}"
USERDIR="${RUNDIR}/userdir"

for platform in $(ls $USERDIR); do
  if [ "$platform" == "common" ]; then continue; fi
  echo "###"
  echo "### Uploading packages for $platform"
  echo "###"
  echo ""
  results="$USERDIR/$platform/results.tar.gz"
  rm -rf "$platform"
  mkdir -p "$platform"
  tar xvf "$results" -C "$platform"
  for pkg in $(ls "$platform"/anaconda/conda-bld/*/*.tar.bz2); do
    binstar upload --force -u cyclus "$pkg"
  done
  rm -rf "$platform"
done
