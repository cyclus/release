#!/bin/bash

# file: maintenence.sh
# description: maintenance task: copy files to cycstub repo

set -e

usage() {

cat <<EOF

Script to perform maintenance task: copy stub files to cycstub

usage: $0

The following environment variables must be set for this script to function:

     CYCLUS_DIR : Environment variable CYCLUS_DIR must be set to the cyclus repository directory.
    CYCSTUB_DIR : Environment variable CYCSTUB_DIR must be set to the cycstub repository directory.

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
CYCSTUB=${CYCSTUB_DIR?"Environment variable CYCSTUB_DIR must be set to the cycstub repository directory."}
echo "Updating cycstub...."

# cycstub
cp $CYCLUS/tests/input/stub_example.xml $CYCSTUB/input/example.xml
cp $CYCLUS/stubs/stub_* $CYCSTUB/src/

