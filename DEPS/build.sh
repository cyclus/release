#!/bin/bash
# This builds cyclist conda packages as well as its dependencies, namely
#  * java-jre
#  * java-jdk
#  * ant
#  * cyclist
set -x 
set -e
shopt -s expand_aliases

# setup
PATH=$(pwd)/anaconda/bin:$PATH:$(pwd)/install/bin
UNAME=$(uname)
BLD=anaconda/conda-bld
if [[ "$UNAME" == "Linux" ]]; then
  sed_i() { sed -i  "$1" "$2"; } 
else
  sed_i() { sed -i '' "$1" "$2"; } 
fi

touch results.tar

conda_build () {
  echo ""
  echo ""
  echo "#######################################"
  echo "#    Building $1 "
  echo "#######################################"
  echo ""
  echo ""
  conda build --no-test --no-binstar-upload $1 
  P=$(ls ${BLD}/*/${1}*.tar.bz2)
  PDIR=$(dirname $P)
  PFILE=$(basename $P)
  tar -uf results.tar -C $PDIR $PFILE
}

# install conda
./bin/conda-inst.sh

# build
if [[ "$UNAME" != "Linux" ]]; then
  conda_build libffi
  conda_build gettext
  conda_build pkg-config-lite
fi
#conda_build glib
conda_build sigcpp
conda_build glibmm
conda_build libxml2
conda_build libxmlpp
conda_build lapack
conda_build boost
conda_build coin
conda_build cyclus-deps

# return packages
gzip results.tar
echo ""
echo "Results Listing"
echo "---------------"
tar -ztvf results.tar.gz

