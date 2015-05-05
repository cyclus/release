#!/bin/bash

# file: maintenence.sh
# author: Matthew Gidden
# description: performs all cyclus project maintenence tasks for a release 

set -e

usage() {

cat <<EOF

Script to perform maintenance tasks related to the release of Cyclus and Cycamore.

usage: $0 <version>

        version : the version string (e.g., X.Y.Z) to with which this package will be labeled.

The following environment variables must be set for this script to function:

     CYCLUS_DIR : Environment variable CYCLUS_DIR must be set to the cyclus repository directory.
   CYCAMORE_DIR : Environment variable CYCAMORE_DIR must be set to the cycamore repository directory.
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
CYCAMORE=${CYCAMORE_DIR?"Environment variable CYCAMORE_DIR must be set to the cycamore repository directory."}
CYCSTUB=${CYCSTUB_DIR?"Environment variable CYCSTUB_DIR must be set to the cycstub repository directory."}
[ "$#" -eq 1 ] || die "Must provide the version (e.g., X.X.X) as an argument"
VERSION=$1
echo "Performing maintence updates for Cyclus stack verison $VERSION"

# pyne
wget https://github.com/pyne/pyne/archive/develop.zip
unzip -d pyne develop.zip
cd pyne
./amalgamate.py -s pyne.cc -i pyne.h
cp pyne.* $CYCLUS/src
cd ..
rm -rf pyne develop.zip

# nuc_data upload
cd $CYCLUS/release
nuc_data_make -o cyclus_nuc_data.h5 \
    -m atomic_mass,scattering_lengths,decay,simple_xs,materials,eaf,wimsd_fpy,nds_fpy
python upload_nuc_data.py
rm -r build_nuc_data cyclus_nuc_data.h5
cd $CYCLUS

# cyclus
cd $CYCLUS/release
./smbchk.py --update -t HEAD --no-save --check | grep "ABI stability has been achieved!"
./smbchk.py --update -t $VERSION
cd $CYCLUS

# cycstub
cp $CYCLUS/tests/input/stub_example.xml $CYCSTUB/input/example.xml
cp $CYCLUS/stubs/stub_* $CYCSTUB/src/

echo "
*-----------------------------------------------------------------------------*
You're almost done!

Cyclus, Cycamore, and Cycstub release candidates still need to be committed and
pushed upstream

Once the candidate passes CI it should be ready to be merged into develop and
master.
*-----------------------------------------------------------------------------*
"
