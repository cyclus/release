dir=$1
version=$2
tmpdir=.tmp_release_dir

mkdir $tmpdir
cd $tmpdir

mtar=$dir/userdir/nmi:x86_64_MacOSX8/results.tar.gz
mkdir mac
cp $mtar mac/
cd mac
binstar upload -u cyclus anaconda/conda-bld/osx-64/cyclus-$version.tar.bz2
binstar upload -u cycamore anaconda/conda-bld/osx-64/cycamore-$version.tar.bz2
cd ..

utar=$dir/userdir/nmi:x86_64_Ubuntu12/results.tar.gz
mkdir ubuntu
cp $utar ubuntu
cd ubuntu
binstar upload -u cyclus anaconda/conda-bld/linux-64/cyclus-$version.tar.bz2
binstar upload -u cycamore anaconda/conda-bld/linux-64/cycamore-$version.tar.bz2
cd ..

cd ..
rm -r $tmpdir