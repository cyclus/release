#!/bin/bash 
# This script takes one argument, which is the BaTLab job Run ID or Global ID

# Setup binstar
which binstar
if [ $? -ne 0 ]; then
  export PATH="${HOME}/miniconda/bin:${PATH}"
fi

set -e
set -x

ID="$1"
if [ "$ID" == "" ]; then echo "Please pass in a run id!"; exit; fi
IFS=':' read -ra RUNDIRS <<< $(nmi_rundir $ID)
RUNDIRS=($RUNDIRS)
RUNDIR="${RUNDIRS[2]}"
USERDIR="${RUNDIR}/userdir"

for platform in $(ls $USERDIR); do
  if [ "$platform" == "common" ]; then continue; fi
  results="$USERDIR/$platform/results.tar.gz"
  mkdir -p "$platform"
  tar xvf "$results" -C "$platform"
  for pkg in $(ls "$platform"/*.tar.bz2); do
    binstar upload -u cyclus "$pkg"
  done
  rm -rf "$platform"
done
