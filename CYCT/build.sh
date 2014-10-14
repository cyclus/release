#!/bin/bash
# This builds cyclist conda packages as well as its dependencies, namely
#  * java-jre
#  * java-jdk
#  * ant
#  * cyclist
set -x 
set -e

PATH=$PATH:`pwd`/install/bin
UNAME=$(uname)
CONDA=anaconda/bin/conda
PKGS=anaconda/pkgs
$CONDA list

conda_build () {
  $CONDA build --no-test --no-binstar-upload $1 
  tar -uf results.tar -C $PKGS $(basename $PKGS/${1}*.tar.bz2)
}

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


