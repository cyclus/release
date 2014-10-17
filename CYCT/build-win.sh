#!/bin/bash
# THIS FILE DOES NOT WORK BECAUSE MINICONDA INSTALLTION FAILS!
# This builds cyclist conda packages as well as its dependencies, namely
#  * java-jre
#  * java-jdk
#  * ant
#  * cyclist
set -x 
set -e
shopt -s expand_aliases

# setup
export PATH="$(pwd)/anaconda:${PATH}"
export PATH="$(pwd)/anaconda/bin:${PATH}"
export PATH="$(pwd)/anaconda/Scripts:${PATH}"
export PATH="$(pwd)/anaconda/Library/bin:${PATH}"
UNAME=$(uname)
BLD=anaconda/conda-bld
CYCLIST_META=cyclist/meta.yaml

touch results.tar
sed -i 's/#fn: /fn: /' $CYCLIST_META
sed -i 's/#url: /url: /' $CYCLIST_META
sed -i 's/git_url: /#git_url: /' $CYCLIST_META
sed -i 's/git_tag: /#git_tag: /' $CYCLIST_META

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
./bin/conda-inst-win.sh

# build
conda_build java-jre
conda_build java-jdk
conda_build ant
conda_build cyclist

# return packages
gzip results.tar
echo ""
echo "Results Listing"
echo "---------------"
tar -ztvf results.tar.gz


