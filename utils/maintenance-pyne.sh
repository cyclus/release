#!/bin/bash

# file: maintenence-pyne.sh
# description: updates PyNE from github as one maintenance step during release

set -e

usage() {

cat <<EOF

Script to update the amalgamated PyNE based on the PyNE github repository

usage: $0 

The following environment variables must be set for this script to function:

     CYCLUS_DIR : Environment variable CYCLUS_DIR must be set to the cyclus repository directory.

EOF

}

die() {
    echo -n >&2 "ERROR: "
    echo >&2 "$@"
    usage
    exit 1
}

# check input
CYCLUS=${CYCLUS_DIR?"Environment variable CYCLUS_DIR must be set to the cyclus repository directory."}
echo "Updating PyNE..."

# pyne
wget https://github.com/pyne/pyne/archive/develop.zip
unzip -d pyne develop.zip
cd pyne
./amalgamate.py -s pyne.cc -i pyne.h
cp pyne.* $CYCLUS/src
cd ..
rm -rf pyne develop.zip

