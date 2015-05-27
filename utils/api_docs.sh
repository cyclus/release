#!/bin/bash

# file: maintenence.sh
# description: performs all cyclus project maintenence tasks for a release 

set -e
set -x

usage() {

cat <<EOF

Script to upload api docs of Cyclus and Cycamore as part of the release process.

usage: $0 <version>

        version : the version string (e.g., X.Y.Z) to with which this package will be labeled.

The following environment variables must be set for this script to function:

     CYCLUS_DIR : Environment variable CYCLUS_DIR must be set to the cyclus repository directory.
   CYCAMORE_DIR : Environment variable CYCAMORE_DIR must be set to the cycamore repository directory.

EOF

}

die() {

    echo -n >&2 "ERROR: "
    echo >&2 "$@"
    usage
    exit 1

}

api_docs() {

    pkg=$1
    branch=$2

    # make docs
    git checkout $branch
    ./install.py --build-only --build-dir=_tmp_build
    cd _tmp_build
    make "$pkg"doc
    cd ..

    # set up remote/branch
    git remote add _tmp_upstream git@github.com:cyclus/$pkg
    git fetch _tmp_upstream
    git checkout -b _tmp_gh_pages _tmp_upstream/gh-pages

    # update website
    rsync -a _tmp_build/doc/html/* api/
    git add "api/*"
    git commit -m "api doc update"
    ## git push remote local_branch:remote_branch
    git push _tmp_upstream _tmp_gh_pages:gh-pages

    # cleanup
    git checkout $branch
    git branch -D _tmp_gh_pages
    git remote rm _tmp_upstream
    rm -rf _tmp_build

}

HERE=$PWD

# check input
CYCLUS=${CYCLUS_DIR?"Environment variable CYCLUS_DIR must be set to the cyclus repository directory."}
CYCAMORE=${CYCAMORE_DIR?"Environment variable CYCAMORE_DIR must be set to the cycamore repository directory."}
[ "$#" -eq 1 ] || die "Must provide the version (e.g., X.X.X) as an argument"
VERSION=$1

echo "Updating API docs for Cyclus stack verison $VERSION"

cd $CYCLUS
api_docs "cyclus" "$VERSION"

cd $CYCAMORE
api_docs "cycamore" "$VERSION"

cd $HERE
