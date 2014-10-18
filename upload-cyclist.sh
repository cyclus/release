#!/bin/bash 
set -e
set -x

# Setup binstar
which binstar
if [ $? -ne 0 ]; then
  export PATH="${HOME}/miniconda/bin:${PATH}"
fi

ID="$1"
IFS=':' read -ra RUNDIRS <<< $(nmi_rundir $ID)
RUNDIR="${RUNDIR[2]}"
USERDIR="${RUNDIR}/userdir"

for x in $(ls $USERDIR); do
  if [ "$x" == "common" ]; then continue; fi
  ls -l $x/results.*
done


#mkdir $tmpdir
#cd $tmpdir

#mtar=$dir/userdir/nmi:x86_64_MacOSX8/results.tar.gz
#mkdir mac
#cp $mtar mac/
#cd mac
#binstar upload -u cyclus anaconda/conda-bld/osx-64/cyclus-$version.tar.bz2
#binstar upload -u cycamore anaconda/conda-bld/osx-64/cycamore-$version.tar.bz2
#cd ..

#utar=$dir/userdir/nmi:x86_64_Ubuntu12/results.tar.gz
#mkdir ubuntu
#cp $utar ubuntu
#cd ubuntu
#binstar upload -u cyclus anaconda/conda-bld/linux-64/cyclus-$version.tar.bz2
#binstar upload -u cycamore anaconda/conda-bld/linux-64/cycamore-$version.tar.bz2
#cd ..

#cd ..
#rm -r $tmpdir