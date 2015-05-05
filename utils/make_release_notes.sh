#!/bin/bash

set -e

usage() {

   cat <<EOF

Script to generate release notes for the current release version relative to a previous version.

usage: $0 <previous>  <version>

       previous : the version string of the previous version (e.g., P.P.P) which provides the
                  basis for determining what is new in the current release
        version : the version string (e.g., V.V.V) to with which this package will be labeled.

NOTE: both version strings must already be existing tags in both the Cyclus and Cycamore repositories.

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

HERE=$PWD

# check input
CYCLUS=${CYCLUS_DIR?"Environment variable CYCLUS_DIR must be set to the cyclus repository directory."}
CYCAMORE=${CYCAMORE_DIR?"Environment variable CYCAMORE_DIR must be set to the cycamore repository directory."}
[ "$#" -eq 2 ] || die "Must provide the from version and to version (e.g., W.W.W -> X.X.X) as an argument"

PREV=$1
VERSION=$2
echo "Making release notes template for Cyclus stack verison $VERSION from $PREV. 

Note, these version names must refer to *existing tags* in all repositories.
"

# cyclus summary
cd $CYCLUS
NCOMMITS=`git rev-list $PREV...$VERSION --count | tail -n1`
SUMMARY=`git diff --stat $PREV...$VERSION | tail -n1`
CYCLUSTXT="$NCOMMITS commits resulting in $SUMMARY"
CYCLUSCONTRIB=`git log --format='%aN' $PREV...$VERSION | sort -u`
cd $HERE

# cycamore summary
cd $CYCAMORE
NCOMMITS=`git rev-list $PREV...$VERSION --count | tail -n1`
SUMMARY=`git diff --stat $PREV...$VERSION | tail -n1`
CYCAMORETXT="$NCOMMITS commits resulting in $SUMMARY"
CYCAMORECONTRIB=`git log --format="%aN" $PREV...$VERSION | sort -u`
cd $HERE

# contributors, beware, thar be hackery ahead
echo "Raw Cyclus core contributors:"
echo "$CYCLUSCONTRIB"
echo ""
echo "$CYCLUSCONTRIB" > .contribs
echo "Raw Cycamore contributors:"
echo "$CYCAMORECONTRIB"
echo ""
echo "$CYCAMORECONTRIB" >> .contribs
CONTRIBTXT=`cat .contribs | sort -u | awk '{print "* " $0}'`
echo "$CONTRIBTXT" > .contribs

# replace
FILE=release_notes.rst
cp -i release_notes.rst.in $FILE
sed -i "s/@PREV_VERSION@/$PREV/g" $FILE 
sed -i "s/@VERSION@/$VERSION/g" $FILE 
sed -i "s/@CYCLUS_SUMMARY@/$CYCLUSTXT/g" $FILE 
sed -i "s/@CYCAMORE_SUMMARY@/$CYCAMORETXT/g" $FILE 
sed -i '/@CONTRIBUTORS@/r .contribs' $FILE 
sed -i '/@CONTRIBUTORS@/d' $FILE 
rm .contribs

echo "
A release notes template is available in release_notes.rst. You still need
to update it with features, etc.!  
"
