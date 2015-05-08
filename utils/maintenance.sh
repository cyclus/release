#!/bin/bash

# file: maintenence.sh
# description: performs all cyclus project maintenence tasks for a release 

set -e

usage() {

cat <<EOF

Script to perform maintenance tasks related to the release of Cyclus and Cycamore.

usage: $0 -v|--version <version_string> [-a|--abi_chk] [-d|--nuc_data] [-p|--pyne] [-s|--stub]

    -v|--version  : provide a version string for these tasks (REQUIRED)
    -a|--abi_chk  : perform test for ABI consistency
    -d|--nuc_data : upload new nuc_data.h5
    -p|--pyne     : update amalgamated PyNE
    -r|--release  : perform ALL tasks for release (same as -a -d -p -s)
    -s|--stub     : update cycstub

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


update_pyne() {

    echo "Updating PyNE..."
    HERE=`pwd`

    wget https://github.com/pyne/pyne/archive/develop.zip
    unzip -d pyne develop.zip
    cd pyne
    ./amalgamate.py -s pyne.cc -i pyne.h
    cp pyne.* $CYCLUS/src
    cd ..
    rm -rf pyne develop.zip

    cd $HERE

}

update_nuc_data() {

    echo "Uploading new nuc_data.h5..."
    HERE=`pwd`

    # nuc_data upload
    cd $CYCLUS/release
    nuc_data_make -o cyclus_nuc_data.h5 \
        -m atomic_mass,scattering_lengths,decay,simple_xs,materials,eaf,wimsd_fpy,nds_fpy
    python upload_nuc_data.py
    rm -r build_nuc_data cyclus_nuc_data.h5

    cd $HERE

}

update_smbchk() {
    
    echo "Confirming ABI stability...."
    HERE=`pwd`

    cd $CYCLUS/release
    ./smbchk.py --update -t HEAD --no-save --check | grep "ABI stability has been achieved!"
    ./smbchk.py --update -t $VERSION
    
    cd $HERE
}

update_stub() {

    echo "Updating cycstub...."
    HERE=`pwd`

    cp $CYCLUS/tests/input/stub_example.xml $CYCSTUB/input/example.xml
    cp $CYCLUS/stubs/stub_* $CYCSTUB/src/

    cd $HERE

}


update_all() {

    echo "
*-----------------------------------------------------------------------------*
You're almost done!

Cyclus, Cycamore, and Cycstub release candidates still need to be committed and
pushed upstream

Once the candidate passes CI it should be ready to be merged into develop and
master.
*-----------------------------------------------------------------------------*
"


}

# check input
CYCLUS=${CYCLUS_DIR?"Environment variable CYCLUS_DIR must be set to the cyclus repository directory."}
CYCAMORE=${CYCAMORE_DIR?"Environment variable CYCAMORE_DIR must be set to the cycamore repository directory."}
CYCSTUB=${CYCSTUB_DIR?"Environment variable CYCSTUB_DIR must be set to the cycstub repository directory."}

VERSION=-1

while [[ $# > 0 ]]
do
    key="$1"

    case $key in
        -p|--pyne)
        UPDATE_PYNE=1
        ;;
        -d|--nuc_data)
        UPDATE_DATA=1
        ;;
        -a|--abi_chk)
        UPDATE_SMBCHK=1
        ;;
        -s|--stub)
        UPDATE_STUB=1
        ;;
        -r|--release)
        UPDATE_PYNE=1
        UPDATE_DATA=1
        UPDATE_SMBCHK=1
        UPDATE_STUB=1
        ;;
        -v|--version)
        VERSION="$2"
        shift
        ;;
        *)
        die "unknown option: $key"
        ;;
    esac
    shift
done

if [[ "$VERSION"       == -1 ]]; then
    die "A version string (e.g. X.Y.Z) must be provided for this maintenace tasks."
fi

UPDATE_ALL=$((UPDATE_DATA+UPDATE_PYNE+UPDATE_SMBCHK+UPDATE_STUB))

if [[ "$UPDATE_ALL"    -eq 0 ]]; then die "No tasks were requested."; fi
if [[ "$UPDATE_PYNE"   -eq 1 ]]; then update_pyne;   fi
if [[ "$UPDATE_DATA"   -eq 1 ]]; then update_data;   fi
if [[ "$UPDATE_SMBCHK" -eq 1 ]]; then update_smbchk; fi
if [[ "$UPDATE_STUB"   -eq 1 ]]; then update_stub;   fi
if [[ "$UPDATE_ALL"    -eq 4 ]]; then update_all;    fi
