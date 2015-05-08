#!/bin/bash

# file: maintenence-nuc_data.sh
# description: release maintenance task: upload updated nuc_data

set -e

usage() {

cat <<EOF

Script to perform maintenance task: upload updated nuc_data

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

echo "Uploading new nuc_data.h5..."

# nuc_data upload
cd $CYCLUS/release
nuc_data_make -o cyclus_nuc_data.h5 \
    -m atomic_mass,scattering_lengths,decay,simple_xs,materials,eaf,wimsd_fpy,nds_fpy
python upload_nuc_data.py
rm -r build_nuc_data cyclus_nuc_data.h5
cd $CYCLUS

