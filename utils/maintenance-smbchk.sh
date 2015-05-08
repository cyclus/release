#!/bin/bash

# file: maintenence-smbchk.sh
# description: maintenance task: update symbol testing of ABI

set -e

usage() {

cat <<EOF

Script to perform maintenance task: check ABI symbols

usage: $0 <version>

        version : the version string (e.g., X.Y.Z) to with which this package will be labeled.

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
[ "$#" -eq 1 ] || die "Must provide the version (e.g., X.X.X) as an argument"
VERSION=$1
echo "Confirming ABI stability...."

cd $CYCLUS/release
./smbchk.py --update -t HEAD --no-save --check | grep "ABI stability has been achieved!"
./smbchk.py --update -t $VERSION
cd $CYCLUS

