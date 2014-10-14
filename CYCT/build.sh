#!/bin/bash
# This builds cyclist conda packages as well as its dependencies, namely
#  * java-jre
#  * java-jdk
#  * ant
#  * cyclist
set -x 
set -e

PATH=$(pwd)/anaconda/bin:$PATH:$(pwd)/install/bin
UNAME=$(uname)
PKGS=anaconda/pkgs

conda_build () {
  conda build --no-test --no-binstar-upload $1 
  tar -uf results.tar -C $PKGS $(basename $PKGS/${1}*.tar.bz2)
}

# Install conda
./bin/conda-inst.sh

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


