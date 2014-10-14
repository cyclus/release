#!/bin/bash
# This builds cyclist conda packages as well as its dependencies, namely
#  * java-jre
#  * java-jdk
#  * ant
#  * cyclist
set -x 
set -e

# setup
PATH=$(pwd)/anaconda/bin:$PATH:$(pwd)/install/bin
UNAME=$(uname)
BLD=anaconda/conda-bld
CYCLIST_META=cyclist/meta.yaml
if [[ "$UNAME" == "LINUX" ]]; then
  alias sed-i="sed -i"
else
  alias sed-i="sed -i ''"
fi

touch results.tar
sed-i 's/#fn: /fn: /' $CYCLIST_META
sed-i 's/#url: /url: /' $CYCLIST_META
sed-i 's/git_url: /#git_url: /' $CYCLIST_META
sed-i 's/git_tag: /#git_tag: /' $CYCLIST_META

conda_build () {
  conda build --no-test --no-binstar-upload $1 
  P=$(ls ${BLD}/*/${1}*.tar.bz2)
  PDIR=$(dirname $P)
  PFILE=$(basename $P)
  tar -uf results.tar -C $PDIR $PFILE
}

# install conda
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


